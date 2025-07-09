import Foundation
import Combine

@MainActor
final class InvitationsViewModel: ObservableObject {

    @Published private(set) var invitations: [AdminInvitation] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    func load(candidateId: Int) {
        Task {
            isLoading = true
            errorMessage = nil
            do {
                invitations = try await fetchInvitations(candidateId: candidateId)
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }

    func refresh(candidateId: Int) {
        load(candidateId: candidateId)
    }

    // Корректная обёртка completion-handler в async/await
    private func fetchInvitations(candidateId: Int) async throws -> [AdminInvitation] {
        try await withCheckedThrowingContinuation { continuation in
            ApiAPI.apiAdminCandidatesInvitationsRetrieve(id: candidateId) { data, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let invitations = data {
                    continuation.resume(returning: invitations)
                } else {
                    continuation.resume(throwing: URLError(.badServerResponse))
                }
            }
        }
    }
}
