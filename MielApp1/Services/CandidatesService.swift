import Foundation

class CandidatesService {
    // Получение списка кандидатов для супервайзера
    func fetch(completion: @escaping (Result<[CandidateInfo], Error>) -> Void) {
        ApiAPI.apiSupervisorCandidatesList { list, error in
            if let error = error {
                completion(.failure(error))
            } else if let list = list {
                completion(.success(list))
            } else {
                completion(.success([]))
            }
        }
    }

    // Добавить или убрать из избранного
    func toggleFavorite(candidate: CandidateInfo, completion: @escaping () -> Void) {
        if candidate.isFavorite {
            ApiAPI.apiSupervisorFavoritesDestroy(id: "\(candidate.favoriteId ?? 0)") { _, _ in
                completion()
            }
        } else {
            let fav = Favorite(
                id: 0,
                candidate: candidate.id,
                candidateInfo: candidate,
                createdAt: Date()
            )
            // Передаём напрямую Favorite, если API его принимает
            ApiAPI.apiSupervisorFavoritesCreate(favorite: fav) { _, _ in
                completion()
            }
        }
    }
}
