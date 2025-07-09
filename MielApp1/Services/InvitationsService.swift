import Foundation

/// Слой, который общается с бэкендом
final class InvitationsService {

    /// Получить список приглашений для супервайзера
    func fetch() async throws -> [Invitation] {
        try await withCheckedThrowingContinuation { continuation in
            ApiAPI.apiSupervisorInvitationsRetrieve { data, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                if let invitations = data {
                    continuation.resume(returning: invitations)
                } else {
                    continuation.resume(returning: [])
                }
            }
        }
    }
}

// MARK: - Утилита
private extension Data {
    /// Упрощённое генерирование Data из словаря
    init(jsonObject: Any) {
        // если вдруг сериализация упадёт – отдадим пустой массив байт
        self = (try? JSONSerialization.data(withJSONObject: jsonObject)) ?? Data()
    }
}
