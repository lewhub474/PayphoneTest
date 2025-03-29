//
//  UserListViewModel.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//

import SwiftUI
import Combine

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var showingError = false
    var errorMessage = ""

    private let getUsersUseCase = GetUsersUseCase()

    func fetchUsers() async {
        do {
            self.users = try await getUsersUseCase.execute()
        } catch {
            showingError = true
            errorMessage = error.localizedDescription
        }
    }
}
