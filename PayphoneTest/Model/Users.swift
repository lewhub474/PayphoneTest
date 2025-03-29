//
//  Users.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let address: Address
    let website: String
    let company: Company

    struct Address: Codable {
        let city: String
    }

    struct Company: Codable {
        let name: String
    }
}
