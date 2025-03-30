//
//  PayphoneTestTests.swift
//  PayphoneTestTests
//
//  Created by Macky on 29/03/25.
//

import XCTest
import RealmSwift
@testable import PayphoneTest

@MainActor
final class UserListViewModelTests: XCTestCase {
    var sut: UserListViewModel! // System Under Test
    var inMemoryRealm: Realm!

    override func setUpWithError() throws {
        // Configuramos un Realm en memoria para pruebas
        var config = Realm.Configuration()
        config.inMemoryIdentifier = "TestRealm" // Identificador único para usar Realm en memoria
        inMemoryRealm = try Realm(configuration: config)
        
        // Limpiamos el Realm antes de cada prueba
        try inMemoryRealm.write {
            inMemoryRealm.deleteAll() // Asegúrate de borrar todos los objetos previos
        }

        // Inicializamos el UserListViewModel
        sut = UserListViewModel()
        sut.realm = inMemoryRealm // Asignamos el Realm en memoria al ViewModel
    }

    override func tearDownWithError() throws {
        sut = nil
        inMemoryRealm = nil
    }

    func testAddUser_newUser_shouldAddUserToRealmAndList() async throws {
        // Dado un usuario nuevo
        let newUser = User()
        newUser.id = 1
        newUser.name = "Juan"
        newUser.username = "juan123"
        newUser.email = "juan@test.com"
        newUser.phone = "123456"

        
        // Cuando añadimos el usuario
        sut.addUser(newUser)
        
        // Esperamos un pequeño retardo para asegurar que las operaciones de escritura terminen
        await Task.yield()

        // Verificamos que el usuario fue añadido a la lista en el ViewModel
        XCTAssertEqual(sut.users.count, 1, "La lista de usuarios debe contener el usuario añadido.")
        XCTAssertEqual(sut.users.first?.name, "Juan", "El usuario añadido debe llamarse Juan.")

        // Verificamos que el usuario también fue añadido al Realm
        let realmUser = inMemoryRealm.object(ofType: User.self, forPrimaryKey: newUser.id)
        XCTAssertNotNil(realmUser, "El usuario debe existir en Realm.")
        XCTAssertEqual(realmUser?.name, "Juan", "El nombre del usuario en Realm debe ser Juan.")
    }
}
