//
//  UserDetailView.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//
import SwiftUI

struct UserDetailView: View {
    let user: User
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Phone: \(user.phone)")
            Text("Website: \(user.website)")
            if let company = user.company {
                Text("Company: \(company.name)")
            }
        }
        .padding()
        .navigationTitle(user.name)
    }
}
