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

    private var realm = try! Realm()

    func fetchUsers() async {
        do {
            // Obtener usuarios de la API
            let fetchedUsers = try await GetUsersUseCase().execute()
            
            DispatchQueue.main.async {
                self.users = fetchedUsers
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

        // Obtener usuarios almacenados en Realm
        let realmUsers = realm.objects(User.self)
        DispatchQueue.main.async {
            self.users.append(contentsOf: realmUsers)
        }
    }

    func addUser(_ user: User) {
        do {
            try realm.write {
                realm.add(user)
            }
            DispatchQueue.main.async {
                self.users.append(user)  // Actualizar la lista inmediatamente
            }
        } catch {
            print("Error al guardar el usuario en Realm: \(error)")
        }
    }

    func deleteUser(at offsets: IndexSet) {
        offsets.forEach { index in
            let user = users[index]
            // Eliminar de Realm
            if let realmUser = realm.object(ofType: User.self, forPrimaryKey: user.id) {
                try! realm.write {
                    realm.delete(realmUser)
                }
            }
            // Eliminar de la lista local
            users.remove(at: index)
        }
    }
}
