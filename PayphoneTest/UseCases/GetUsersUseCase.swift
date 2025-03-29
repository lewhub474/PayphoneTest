//
//  UsesCases.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//

class GetUsersUseCase {
    private let userService = UserService()

    func execute() async throws -> [User] {
        return try await userService.fetchUsers()
    }
}
