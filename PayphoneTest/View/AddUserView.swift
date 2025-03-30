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
    @StateObject private var addUserViewModel = AddUserViewModel()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
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
                    
                    TextField("Ciudad", text: $addUserViewModel.city)
                        .onChange(of: addUserViewModel.city) { _ in
                            addUserViewModel.validateForm()
                        }
                    
                    // Campo para el nombre de la compañía
                    TextField("Compañía", text: $addUserViewModel.companyName)
                        .onChange(of: addUserViewModel.companyName) { _ in
                            addUserViewModel.validateForm()
                        }
                    
                    TextField("Sitio web", text: $addUserViewModel.website)
                        .onChange(of: addUserViewModel.website) { _ in
                            addUserViewModel.validateForm()
                        }
                    
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(0)
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

