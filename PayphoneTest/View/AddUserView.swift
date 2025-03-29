//
//  AddUserView.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//

import SwiftUI
import RealmSwift

struct AddUserView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: UserListViewModel

    @State private var name = ""
    @State private var username = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var city = ""

    var body: some View {
        Form {
            TextField("Nombre completo", text: $name)
            TextField("Nombre de usuario", text: $username)
            TextField("Correo electrónico", text: $email)
            TextField("Teléfono", text: $phone)
            TextField("Ciudad", text: $city)
            
            Button("Guardar usuario") {
                let newUser = User() // Inicializador por defecto
                newUser.id = Int.random(in: 1...1000)
                newUser.name = name
                newUser.username = username
                newUser.email = email
                newUser.phone = phone
                newUser.city = city
                
                viewModel.addUser(newUser) // Aquí se guarda el usuario en Realm
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Agregar Usuario")
    }
}
