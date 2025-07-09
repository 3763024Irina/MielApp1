import Foundation

@MainActor
final class DashboardViewModel: ObservableObject {

    @Published private(set) var invitations: [AdminInvitation] = []
    @Published private(set) var invitationStatistics: [InvitationStatistics] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    func loadInvitations(candidateId: Int) {
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

    func loadInvitationStatistics(startDate: String? = nil, endDate: String? = nil, officeId: String? = nil) {
        Task {
            isLoading = true
            errorMessage = nil
            do {
                invitationStatistics = try await fetchInvitationStatistics(startDate: startDate, endDate: endDate, officeId: officeId)
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }

    // Обертки для completion-based API в async/await
    private func fetchInvitations(candidateId: Int) async throws -> [AdminInvitation] {
        try await withCheckedThrowingContinuation { continuation in
            ApiAPI.apiAdminCandidatesInvitationsRetrieve(id: candidateId) { data, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data {
                    continuation.resume(returning: data)
                } else {
                    continuation.resume(throwing: URLError(.badServerResponse))
                }
            }
        }
    }

    private func fetchInvitationStatistics(
        startDate: String?,
        endDate: String?,
        officeId: String?
    ) async throws -> [InvitationStatistics] {
        try await withCheckedThrowingContinuation { continuation in
            ApiAPI.apiAdminStatisticInvitationsList(
                endDate: endDate,
                officeId: officeId,
                startDate: startDate
            ) { data, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let statistics = data {
                    continuation.resume(returning: statistics)
                } else {
                    continuation.resume(throwing: URLError(.badServerResponse))
                }
            }
        }
    }



    // Метод повторной попытки (retry)
    func retry(candidateId: Int) {
        loadInvitations(candidateId: candidateId)
    }

    // Для pull-to-refresh
    func refresh(candidateId: Int) {
        loadInvitations(candidateId: candidateId)
    }
}
