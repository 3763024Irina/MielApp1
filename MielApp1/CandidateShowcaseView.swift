import SwiftUI

struct CandidateShowcaseView: View {
    @EnvironmentObject var session: SessionStore
    @StateObject private var viewModel = CandidatesListViewModel()
    @State private var showFilter = false
    @State private var showInvitations = false
    @State private var selectedCandidateId: Int? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 🧑‍💼 Шапка супервайзера
            if !session.fullName.isEmpty {
                SupervisorHeaderView(
                    fullName: session.fullName,
                    date: formattedDate(Date()),
                    photoURL: session.photoURL,
                    onNotifications: { print("Уведомления") },
                    onLogout: { session.signOut() }
                )
            }

            // 🟨 Верхний бар с кнопками
            HStack {
                Button("Квоты \(session.officeQuota)") {}
                    .padding(.vertical, 6)
                    .padding(.horizontal, 24)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.red, lineWidth: 2))

                Button("Приглашения \(session.officeUsedQuota)") {
                    // Открыть общий экран приглашений (если нужен)
                    // Или реализуй по-другому
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 24)
                .background(Color.green.opacity(0.12))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.green, lineWidth: 2))

                Spacer()

                Button("Запросить квоту") {}
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            .padding(.horizontal)
            .padding(.top, 8)

            // 🧭 Заголовок и фильтр
            HStack {
                Text("Витрина кандидатов")
                    .font(.headline.bold())
                    .foregroundColor(Color(red: 150/255, green: 0/255, blue: 71/255))

                Spacer()

                Button {
                    showFilter.toggle()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                        Text("Фильтр").font(.caption)
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)

            // ❗ Ошибка
            if let error = viewModel.error {
                Text("Ошибка: \(error)")
                    .foregroundColor(.red)
                    .padding()
            }

            // 📋 Список кандидатов
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.candidates, id: \.id) { candidate in
                        CandidateCellView(
                            candidate: candidate,
                            onInvite: {
                                selectedCandidateId = candidate.id
                                showInvitations = true
                            },
                            onToggleFavorite: {
                                viewModel.toggleFavorite(candidate: candidate)
                            }
                        )
                        .padding(.horizontal)
                    }
                }
            }
            .sheet(isPresented: $showFilter) {
                VStack {
                    Text("Фильтр — скоро!")
                        .font(.title)
                    Button("Закрыть") {
                        showFilter = false
                    }
                }
                .padding()
            }
            // 📬 Модалка приглашений для выбранного кандидата
            .sheet(isPresented: $showInvitations) {
                if let candidateId = selectedCandidateId {
                    InvitationsScreen(candidateId: candidateId)
                        .environmentObject(session)
                }
            }
        }
        .onAppear {
            viewModel.load()
            session.fetchInfo()
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: date)
    }
}
