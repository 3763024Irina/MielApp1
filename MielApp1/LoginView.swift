//экран авторизации
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: SessionStore
    @State private var username = "supervisor"
    @State private var password = "supervisor"

    var body: some View {
        VStack(spacing: 16) {
            Text("Вход в систему")
                .font(.largeTitle)
            TextField("Логин", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            SecureField("Пароль", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Войти") {
                session.signIn(username: username, password: password)
            }
            .padding()
        }
        .padding()
    }
}
