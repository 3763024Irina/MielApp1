import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // 1. Витрина
            NavigationStack {
                CandidateShowcaseView()
                    .environmentObject(SessionStore.shared)
            }
            .tabItem {
                Image(systemName: "square.grid.2x2")
                Text("Витрина")
            }

            // 2. Избранное
            NavigationStack {
                FavoritesScreen()
            }
            .tabItem {
                Image(systemName: "heart")
                Text("Избранное")
            }

            // 3. Приглашения
            NavigationStack {
                InvitationsScreen(candidateId: 1) // <--- укажи id для теста или подставляй реальный id
            }
            .tabItem {
                Image(systemName: "paperplane")
                Text("Приглашения")
            }

            // 4. Квоты
            NavigationStack {
                QuotaScreen()
            }
            .tabItem {
                Image(systemName: "chart.bar")
                Text("Квоты")
            }
        }
        .accentColor(Color(red: 176/255, green: 7/255, blue: 87/255))
    }
}
