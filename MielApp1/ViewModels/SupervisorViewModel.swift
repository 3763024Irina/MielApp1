//
//  SupervisorViewModel.swift
//  MielApp1
//
//  Created by Irina on 7/7/25.
//

import Foundation
import Combine

class SupervisorViewModel: ObservableObject {
    @Published var supervisor: Supervisor?
    @Published var error: String?

    // Если нужен просто любой (первый) супервайзер
    func loadSupervisor() {
        ApiAPI.apiAdminSupervisorsList { [weak self] data, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.error = error.localizedDescription
                } else if let supervisors = data, let current = supervisors.first {
                    self?.supervisor = current
                } else {
                    self?.error = "Нет данных о супервайзере"
                }
            }
        }
    }
}
