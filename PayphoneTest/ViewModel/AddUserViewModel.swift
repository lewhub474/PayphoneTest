//
//  AddUserViewModel.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//

import SwiftUI

@MainActor
class AddUserViewModel: ObservableObject {
    @Published var name = ""
    @Published var username = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var city = ""
    @Published var isFormValid = false
    @Published var formError = ""

    func validateForm() {
        if name.isEmpty || username.isEmpty || email.isEmpty || phone.isEmpty || city.isEmpty {
            formError = "Por favor, completa todos los campos."
            isFormValid = false
        } else if !isValidEmail(email) {
            formError = "Correo electrónico no es válido."
            isFormValid = false
        } else {
            formError = ""
            isFormValid = true
        }
    }

     func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func saveUser(using viewModel: UserListViewModel) {
        let newUser = User()
        newUser.id = Int.random(in: 1...1000)
        newUser.name = name
        newUser.username = username
        newUser.email = email
        newUser.phone = phone
        newUser.city = city
        viewModel.addUser(newUser)
    }
}
