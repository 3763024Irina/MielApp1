//
//  CandidateListViewModel.swift
//  ViewModel, загружает кандидатов через сервис
import Foundation
import Combine

class CandidatesListViewModel: ObservableObject {
    @Published var candidates: [CandidateInfo] = []
    @Published var error: String?
    private let service = CandidatesService()

    func load() {
        service.fetch { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let list):
                    // Маппим каждую Candidate в CandidateInfo
                    self?.candidates = list

                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }


    func toggleFavorite(candidate: CandidateInfo) {
        service.toggleFavorite(candidate: candidate) { [weak self] in
            // Повторная загрузка списка после изменения избранного
            self?.load()
        }
    }
}

// Extension для удобства преобразования
extension Candidate {
    func asCandidateInfo() -> CandidateInfo {
        CandidateInfo(
            id: id,
            name: name,
            surname: surname,
            patronymic: patronymic,
            birth: birth,
            age: age,
            education: education,
            photo: photo,
            country: country,
            city: city,
            resume: resume,
            courses: courses,
            updatedAt: updatedAt,
            isFavorite: false, // Добавь свою логику если надо
            favoriteId: nil,   // Добавь свою логику если надо
            isInvited: false,  // Добавь свою логику если надо
            achivmentObjects: achivmentObjects,
            achivmentClients: achivmentClients,
            achivmentLeads: achivmentLeads,
            achivmentExclusives: achivmentExclusives,
            achivmentDeals: achivmentDeals
        )
    }
}
