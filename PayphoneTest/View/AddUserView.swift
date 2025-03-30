//
//  AddUserView.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//


//import SwiftUI
//import RealmSwift
//
//struct AddUserView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @StateObject var viewModel: UserListViewModel
//    @StateObject private var addUserViewModel = AddUserViewModel()
//    @StateObject private var locationManager = LocationManager()
//
//    var body: some View {
//        VStack {
//            Form {
//                TextField("Nombre completo", text: $addUserViewModel.name)
//                    .onChange(of: addUserViewModel.name) { _ in
//                        addUserViewModel.validateForm()
//                    }
//
//                TextField("Nombre de usuario", text: $addUserViewModel.username)
//                    .onChange(of: addUserViewModel.username) { _ in
//                        addUserViewModel.validateForm()
//                    }
//
//                TextField("Correo electrónico", text: $addUserViewModel.email)
//                    .onChange(of: addUserViewModel.email) { _ in
//                        addUserViewModel.validateForm()
//                    }
//                    .keyboardType(.emailAddress)
//                
//                if !addUserViewModel.isValidEmail(addUserViewModel.email) && !addUserViewModel.email.isEmpty {
//                    Text("Correo electrónico no es válido")
//                        .font(.caption)
//                        .foregroundColor(.red)
//                }
//
//                TextField("Teléfono", text: $addUserViewModel.phone)
//                    .onChange(of: addUserViewModel.phone) { _ in
//                        addUserViewModel.validateForm()
//                    }
//                    .keyboardType(.phonePad)
//
//                TextField("Ciudad", text: $addUserViewModel.city)
//                    .onChange(of: addUserViewModel.city) { _ in
//                        addUserViewModel.validateForm()
//                    }
//            }
//
//            // Botón para obtener la ubicación actual
//            Button(action: {
//                locationManager.requestLocationPermission()
//                locationManager.getCurrentLocation()
//            }) {
//                Text("Obtener ubicación actual")
//                    .font(.headline)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//
//            if !addUserViewModel.formError.isEmpty {
//                Text(addUserViewModel.formError)
//                    .font(.caption)
//                    .foregroundColor(.red)
//                    .padding(.top, 5)
//            }
//
//            Button("Guardar usuario") {
//                addUserViewModel.saveUser(using: viewModel)
//                presentationMode.wrappedValue.dismiss()
//            }
//            .font(.headline)
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//            .disabled(!addUserViewModel.isFormValid)
//            .padding(.top, 20)
//        }
//        .navigationTitle("Agregar Usuario")
//        .onAppear {
//            addUserViewModel.validateForm() // Validar al cargar la vista
//        }
//        .alert(isPresented: $locationManager.showLocationPopup) {
//            if let locationError = locationManager.locationError {
//                // Mostrar mensaje de error si no se pudo obtener la ubicación
//                return Alert(
//                    title: Text("Error"),
//                    message: Text(locationError),
//                    dismissButton: .default(Text("OK"))
//                )
//            } else {
//                // Mostrar detalles de la ubicación obtenida
//                return Alert(
//                    title: Text("Ubicación obtenida"),
//                    message: Text("Ciudad: \(locationManager.city)\nLatitud: \(locationManager.latitude)\nLongitud: \(locationManager.longitude)"),
//                    dismissButton: .default(Text("OK"))
//                )
//            }
//        }
//    }
//}


//import SwiftUI
//import RealmSwift
//
//struct AddUserView: View { 2
//    @Environment(\.presentationMode) var presentationMode
//    @StateObject var viewModel: UserListViewModel
//    @StateObject private var addUserViewModel = AddUserViewModel()
//    @StateObject private var locationManager = LocationManager()
//
//    var body: some View {
//        ZStack {
//            VStack {
//                Form {
//                    TextField("Nombre completo", text: $addUserViewModel.name)
//                        .onChange(of: addUserViewModel.name) { _ in
//                            addUserViewModel.validateForm()
//                        }
//
//                    TextField("Nombre de usuario", text: $addUserViewModel.username)
//                        .onChange(of: addUserViewModel.username) { _ in
//                            addUserViewModel.validateForm()
//                        }
//
//                    TextField("Correo electrónico", text: $addUserViewModel.email)
//                        .onChange(of: addUserViewModel.email) { _ in
//                            addUserViewModel.validateForm()
//                        }
//                        .keyboardType(.emailAddress)
//
//                    if !addUserViewModel.isValidEmail(addUserViewModel.email) && !addUserViewModel.email.isEmpty {
//                        Text("Correo electrónico no es válido")
//                            .font(.caption)
//                            .foregroundColor(.red)
//                    }
//
//                    TextField("Teléfono", text: $addUserViewModel.phone)
//                        .onChange(of: addUserViewModel.phone) { _ in
//                            addUserViewModel.validateForm()
//                        }
//                        .keyboardType(.phonePad)
//
//                    TextField("Ciudad", text: $addUserViewModel.city)
//                        .onChange(of: addUserViewModel.city) { _ in
//                            addUserViewModel.validateForm()
//                        }
//                }
//
//                if !addUserViewModel.formError.isEmpty {
//                    Text(addUserViewModel.formError)
//                        .font(.caption)
//                        .foregroundColor(.red)
//                        .padding(.top, 5)
//                }
//
//                Button("Guardar usuario") {
//                    addUserViewModel.saveUser(using: viewModel)
//                    presentationMode.wrappedValue.dismiss()
//                }
//                .font(.headline)
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.gray)
//                .cornerRadius(8)
//                .disabled(!addUserViewModel.isFormValid)
//                .padding(.top, 20)
//            }
//
//            // Botón flotante para obtener la ubicación actual
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        locationManager.requestLocationPermission()
//                        locationManager.getCurrentLocation()
//                    }) {
//                        Image(systemName: "location.fill")
//                            .font(.system(size: 24))
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .clipShape(Circle())
//                            .shadow(radius: 5)
//                    }
//                    .padding()
//                }
//            }
//        }
//        .navigationTitle("Agregar Usuario")
//        .onAppear {
//            addUserViewModel.validateForm() // Validar al cargar la vista
//        }
//        .alert(isPresented: $locationManager.showLocationPopup) {
//            if let locationError = locationManager.locationError {
//                // Mostrar mensaje de error si no se pudo obtener la ubicación
//                return Alert(
//                    title: Text("Error"),
//                    message: Text(locationError),
//                    dismissButton: .default(Text("OK"))
//                )
//            } else {
//                // Mostrar detalles de la ubicación obtenida
//                return Alert(
//                    title: Text("Ubicación obtenida"),
//                    message: Text("Ciudad: \(locationManager.city)\nLatitud: \(locationManager.latitude)\nLongitud: \(locationManager.longitude)"),
//                    dismissButton: .default(Text("OK"))
//                )
//            }
//        }
//    }
//}

//import SwiftUI
//import RealmSwift
//
//struct AddUserView: View { 2
//    @Environment(\.presentationMode) var presentationMode
//    @StateObject var viewModel: UserListViewModel
//    @StateObject private var addUserViewModel = AddUserViewModel()
//    @StateObject private var locationManager = LocationManager()
//
//    var body: some View {
//        ZStack {
//            VStack {
//                Form {
//                    TextField("Nombre completo", text: $addUserViewModel.name)
//                        .onChange(of: addUserViewModel.name) { _ in
//                            addUserViewModel.validateForm()
//                        }
//
//                    TextField("Nombre de usuario", text: $addUserViewModel.username)
//                        .onChange(of: addUserViewModel.username) { _ in
//                            addUserViewModel.validateForm()
//                        }
//
//                    TextField("Correo electrónico", text: $addUserViewModel.email)
//                        .onChange(of: addUserViewModel.email) { _ in
//                            addUserViewModel.validateForm()
//                        }
//                        .keyboardType(.emailAddress)
//
//                    if !addUserViewModel.isValidEmail(addUserViewModel.email) && !addUserViewModel.email.isEmpty {
//                        Text("Correo electrónico no es válido")
//                            .font(.caption)
//                            .foregroundColor(.red)
//                    }
//
//                    TextField("Teléfono", text: $addUserViewModel.phone)
//                        .onChange(of: addUserViewModel.phone) { _ in
//                            addUserViewModel.validateForm()
//                        }
//                        .keyboardType(.phonePad)
//
//                    TextField("Ciudad", text: $addUserViewModel.city)
//                        .onChange(of: addUserViewModel.city) { _ in
//                            addUserViewModel.validateForm()
//                        }
//                }
//
//                if !addUserViewModel.formError.isEmpty {
//                    Text(addUserViewModel.formError)
//                        .font(.caption)
//                        .foregroundColor(.red)
//                        .padding(.top, 5)
//                }
//
//                Button("Guardar usuario") {
//                    addUserViewModel.saveUser(using: viewModel)
//                    presentationMode.wrappedValue.dismiss()
//                }
//                .font(.headline)
//                .padding()
//                .background(addUserViewModel.isFormValid ? Color.blue : Color.gray) // Cambiar color de fondo
//                .foregroundColor(.white) // Color del texto siempre blanco
//                .cornerRadius(8)
//                .disabled(!addUserViewModel.isFormValid)
//                .padding(.top, 20)
//            }
//
//            // Botón flotante para obtener la ubicación actual
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        locationManager.requestLocationPermission()
//                        locationManager.getCurrentLocation()
//                    }) {
//                        Image(systemName: "location.fill")
//                            .font(.system(size: 24))
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .clipShape(Circle())
//                            .shadow(radius: 5)
//                    }
//                    .padding()
//                }
//            }
//        }
//        .navigationTitle("Añadir Usuario") // Utilizando navigationTitle en vez de un Text manual
////        .navigationBarTitleDisplayMode(.inline) // Mostrar el título de forma compacta
//        .onAppear {
//            addUserViewModel.validateForm() // Validar al cargar la vista
//        }
//        .alert(isPresented: $locationManager.showLocationPopup) {
//            if let locationError = locationManager.locationError {
//                // Mostrar mensaje de error si no se pudo obtener la ubicación
//                return Alert(
//                    title: Text("Error"),
//                    message: Text(locationError),
//                    dismissButton: .default(Text("OK"))
//                )
//            } else {
//                // Mostrar detalles de la ubicación obtenida
//                return Alert(
//                    title: Text("Ubicación obtenida"),
//                    message: Text("Ciudad: \(locationManager.city)\nLatitud: \(locationManager.latitude)\nLongitud: \(locationManager.longitude)"),
//                    dismissButton: .default(Text("OK"))
//                )
//            }
//        }
//    }
//}

import SwiftUI
import RealmSwift

struct AddUserView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: UserListViewModel
    @StateObject private var addUserViewModel = AddUserViewModel()
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Form {
                        TextField("Nombre completo", text: $addUserViewModel.name)
                            .onChange(of: addUserViewModel.name) { _ in
                                addUserViewModel.validateForm()
                            }

                        TextField("Nombre de usuario", text: $addUserViewModel.username)
                            .onChange(of: addUserViewModel.username) { _ in
                                addUserViewModel.validateForm()
                            }

                        TextField("Correo electrónico", text: $addUserViewModel.email)
                            .onChange(of: addUserViewModel.email) { _ in
                                addUserViewModel.validateForm()
                            }
                            .keyboardType(.emailAddress)

                        if !addUserViewModel.isValidEmail(addUserViewModel.email) && !addUserViewModel.email.isEmpty {
                            Text("Correo electrónico no es válido")
                                .font(.caption)
                                .foregroundColor(.red)
                        }

                        TextField("Teléfono", text: $addUserViewModel.phone)
                            .onChange(of: addUserViewModel.phone) { _ in
                                addUserViewModel.validateForm()
                            }
                            .keyboardType(.phonePad)

                        TextField("Ciudad", text: $addUserViewModel.city)
                            .onChange(of: addUserViewModel.city) { _ in
                                addUserViewModel.validateForm()
                            }
                    }

                    if !addUserViewModel.formError.isEmpty {
                        Text(addUserViewModel.formError)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.top, 5)
                    }

                    Button("Guardar usuario") {
                        addUserViewModel.saveUser(using: viewModel)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.headline)
                    .padding()
                    .background(addUserViewModel.isFormValid ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .disabled(!addUserViewModel.isFormValid)
                    .padding(.top, 20)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            locationManager.requestLocationPermission()
                            locationManager.getCurrentLocation()
                        }) {
                            Image(systemName: "location.fill")
                                .font(.system(size: 28))
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 6)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Añadir Usuario")
            .onAppear {
                addUserViewModel.validateForm()
            }
            .alert(isPresented: $locationManager.showLocationPopup) {
                if let locationError = locationManager.locationError {
                    return Alert(
                        title: Text("Error"),
                        message: Text(locationError),
                        dismissButton: .default(Text("OK"))
                    )
                } else {
                    return Alert(
                        title: Text("Ubicación obtenida"),
                        message: Text("\nLatitud: \(locationManager.latitude)\nLongitud: \(locationManager.longitude)"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
}
