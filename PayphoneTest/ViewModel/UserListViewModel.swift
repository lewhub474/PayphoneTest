//
//  UserListViewModel.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//

import SwiftUI
import Combine
import Realm
import RealmSwift

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var showingError = false
    @Published var errorMessage = ""
    @Published var showAddUserView = false
    
    private var realm: Realm
    
    init() {
        realm = try! Realm()
        loadUsersFromRealm()
    }
    
    func fetchUsers() async {
        loadUsersFromRealm()
        do {
            let fetchedUsers = try await GetUsersUseCase().execute()
            saveUsersToRealm(fetchedUsers)
            let realmUsers = Array(realm.objects(User.self))
            let combinedUsers = Array(Set(fetchedUsers).union(Set(realmUsers)))
            
            DispatchQueue.main.async {
                self.users = combinedUsers
            }
        } catch let error as NetworkError {
            DispatchQueue.main.async {
                self.showingError = true
                self.errorMessage = error.localizedDescription
            }
        } catch {
            DispatchQueue.main.async {
                self.showingError = true
                self.errorMessage = "Ocurrió un error inesperado."
            }
        }
    }
    
    private func loadUsersFromRealm() {
        let realmUsers = realm.objects(User.self)
        DispatchQueue.main.async {
            self.users = Array(realmUsers)
        }
    }
    
    private func saveUsersToRealm(_ users: [User]) {
        do {
            try realm.write {
                realm.add(users, update: .modified)
            }
        } catch {
            print("Error al guardar usuarios en Realm: \(error)")
        }
    }
    
    func addUser(_ user: User) {
        if realm.object(ofType: User.self, forPrimaryKey: user.id) != nil {
            print("El usuario con id \(user.id) ya existe, no se añadirá.")
            return
        }
        do {
            try realm.write {
                realm.add(user)
            }
            DispatchQueue.main.async {
                self.users.append(user)
            }
        } catch {
            print("Error al guardar el usuario en Realm: \(error)")
        }
    }
    
    func deleteUser(at offsets: IndexSet) {
        offsets.forEach { index in
            let user = users[index]
            if let realmUser = realm.object(ofType: User.self, forPrimaryKey: user.id) {
                try! realm.write {
                    realm.delete(realmUser)
                }
            }
            users.remove(at: index)
        }
    }
}
