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
        // Inicializar Realm
        realm = try! Realm()
        // Cargar usuarios locales al iniciar el ViewModel
        loadUsersFromRealm()
    }
    
    func fetchUsers() async {
        // Cargar usuarios desde Realm antes de intentar la API
        loadUsersFromRealm()

        do {
            // Obtener usuarios de la API
            let fetchedUsers = try await GetUsersUseCase().execute()

            // Guardar los usuarios obtenidos en Realm
            saveUsersToRealm(fetchedUsers)

            // Combinar usuarios evitando duplicados por ID
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

    // Cargar usuarios almacenados localmente desde Realm
    private func loadUsersFromRealm() {
        let realmUsers = realm.objects(User.self)
        DispatchQueue.main.async {
            self.users = Array(realmUsers)
        }
    }

    // Guardar los usuarios en la base de datos Realm
    private func saveUsersToRealm(_ users: [User]) {
        do {
            try realm.write {
                realm.add(users, update: .modified)  // .modified solo actualiza los existentes, no duplica
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
