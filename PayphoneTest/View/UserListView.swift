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
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.users) { user in
                        NavigationLink(destination: UserDetailView(user: user)
                            .environmentObject(coordinator)) {
                                VStack(alignment: .leading, spacing: 10) {
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
                .listStyle(PlainListStyle()) 
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
            .overlay(
                Button(action: {
                    showingAddUserView = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 30))
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 6)
                }
                    .padding(),
                alignment: .bottomTrailing
            )
            .sheet(isPresented: $showingAddUserView) {
                AddUserView(viewModel: viewModel)
                    .environmentObject(coordinator)
            }
        }
    }
}
