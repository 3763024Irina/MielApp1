import Foundation
import Combine

@MainActor
final class SessionStore: ObservableObject {
    static let shared = SessionStore()

    @Published private(set) var token: String? {
        didSet {
            if let token {
                MielClientAPI.customHeaders["Authorization"] = "Token \(token)"
                print("✅ Токен установлен: \(token)")
            } else {
                MielClientAPI.customHeaders.removeValue(forKey: "Authorization")
                print("🧹 Токен удалён")
            }
        }
    }
    @Published private(set) var isLoggedIn = false
    @Published private(set) var userInfo: [String: Any] = [:]

    private init() {}

    // --- Вычисляемые поля для UI ---
    var fullName: String { userInfo["full_name"] as? String ?? "" }
    var photoURL: URL? {
        guard let s = userInfo["photo"] as? String, !s.isEmpty else { return nil }
        return URL(string: s)
    }
    var role: Int {
        if let n = userInfo["role"] as? Int { return n }
        if let s = userInfo["role"] as? String, let n = Int(s) { return n }
        return 0
    }
    var officeName: String { userInfo["office_name"] as? String ?? "" }
    var officeLocation: String { userInfo["office_location"] as? String ?? "" }
    var department: String { userInfo["department"] as? String ?? "" }
    var officeQuota: Int {
        if let n = userInfo["office_quota"] as? Int { return n }
        if let s = userInfo["office_quota"] as? String, let n = Int(s) { return n }
        return 0
    }
    var officeUsedQuota: Int {
        if let n = userInfo["office_used_quota"] as? Int { return n }
        if let s = userInfo["office_used_quota"] as? String, let n = Int(s) { return n }
        return 0
    }

    // --- Авторизация ---
    func signIn(username: String, password: String) {
        let body = AnyCodable(["username": username, "password": password])
        ApiAPI.apiLoginCreate(body: body) { [weak self] data, error in
            guard let self else { return }

            print("🚨 Login RAW response:", data?.value ?? "nil")
            if let error { self.log(error); return }

            var token: String? = nil
            if let dict = data?.value as? [String: Any] {
                token = dict["token"] as? String
                // Fallback: ищем любую строку >16 символов, если вдруг ключ другой
                if token == nil {
                    token = dict.values.compactMap { $0 as? String }.first { $0.count > 16 }
                }
            }
            guard let token else {
                print("❌ Токен не найден в ответе login: \(String(describing: data?.value))")
                return
            }

            Task { @MainActor in
                self.token = token
                self.isLoggedIn = true
                self.fetchInfo()
            }
        }
    }

    // --- Выход ---
    func signOut() {
        ApiAPI.apiLogoutCreate { [weak self] _, _ in
            guard let self else { return }
            Task { @MainActor in
                self.token      = nil
                self.isLoggedIn = false
                self.userInfo   = [:]
            }
        }
    }

    // --- Получение /api/info/ ---
    func fetchInfo() {
        ApiAPI.apiInfoRetrieve { [weak self] data, error in
            guard let self else { return }
            if let error { self.log(error); return }
            guard let raw = data?.value else { print("❌ Пустой ответ /api/info/"); return }

            // Если сервер вернул массив — берём первый элемент
            let payload: Any = (raw as? [Any])?.first ?? raw
            var cleaned: [String: Any]? = nil
            if let dictCodable = payload as? [String: AnyCodable] {
                cleaned = dictCodable.mapValues { $0.value }
            } else if let dict = payload as? [String: Any] {
                cleaned = dict
            } else {
                print("❌ Неожиданный формат /api/info/: \(type(of: payload))")
            }
            if let cleaned {
                Task { @MainActor in
                    self.userInfo = cleaned
                    print("✅ /api/info/ принято: \(cleaned)")
                }
            }
        }
    }

    // --- Логирование ---
    private func log(_ error: Error) {
        if let ns = error as? NSError,
           let d  = ns.userInfo["data"] as? Data,
           let s  = String(data: d, encoding: .utf8) {
            print("📦 Ответ сервера: \(s)")
        }
        print("❌ \(error)")
    }
}
