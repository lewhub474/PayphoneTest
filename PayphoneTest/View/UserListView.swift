//
//  UserListView.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
    @State private var showingAddUserView = false

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
                        Text(user.city)
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Usuarios")
            .onAppear {
                Task {
                    await viewModel.fetchUsers()  // Cargar usuarios al aparecer la vista
                }
            }
            .alert(isPresented: $viewModel.showingError) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $showingAddUserView) {
                AddUserView(viewModel: viewModel)  // Pasar el ViewModel
            }
            .overlay(
                Button(action: {
                    showingAddUserView = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 24))
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(),
                alignment: .bottomTrailing
            )
        }
    }
}
