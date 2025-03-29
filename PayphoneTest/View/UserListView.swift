//
//  UserListView.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                NavigationLink(destination: UserDetailView(user: user)) {
                    VStack(alignment: .leading) {
                        Text(user.username)
                            .font(.headline)
                        Text(user.name)
                            .font(.subheadline)
                        Text(user.email)
                            .font(.subheadline)
                        Text(user.phone)
                            .font(.subheadline)
                        Text(user.address.city)
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Usuarios")
            .onAppear {
                Task {
                    await viewModel.fetchUsers()
                }
            }
            .alert(isPresented: $viewModel.showingError) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}
