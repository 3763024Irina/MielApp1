import SwiftUI

@main
struct MielApp1App: App {
    @StateObject var session = SessionStore.shared

      var body: some Scene {
          WindowGroup {
              if session.isLoggedIn {
                  MainTabView()
                      .environmentObject(session)
              } else {
                  LoginView()
                      .environmentObject(session)
              }
          }
      }
  }
