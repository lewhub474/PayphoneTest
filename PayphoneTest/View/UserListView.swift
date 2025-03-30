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
            VStack  {
                List {
                    ForEach(viewModel.users) { user in
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
                    .onDelete(perform: viewModel.deleteUser)
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
            .sheet(isPresented: $showingAddUserView) {
                AddUserView(viewModel: viewModel)
            }
            .overlay(
                Button(action: {
                    showingAddUserView = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 30))
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 6)
                }
                    .padding(),
                alignment: .bottomTrailing
            )
        }
    }
}
