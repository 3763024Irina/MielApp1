import SwiftUI

struct InvitationsScreen: View {
    @StateObject private var viewModel = InvitationsViewModel()
    let candidateId: Int

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Загрузка...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Text("Ошибка: \(error)")
                            .foregroundColor(.red)
                        Button("Повторить") {
                            viewModel.refresh(candidateId: candidateId)
                        }
                    }
                } else if viewModel.invitations.isEmpty {
                    Text("Нет приглашений")
                        .foregroundColor(.gray)
                } else {
                    List(viewModel.invitations, id: \.id) { item in
                        InvitationRowView(item: item)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        viewModel.refresh(candidateId: candidateId)
                    }
                }
            }
            .navigationTitle("Приглашения") // <-- здесь теперь правильно!
        }
        .onAppear {
            viewModel.load(candidateId: candidateId)
        }
    }
}
