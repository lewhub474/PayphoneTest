//
//  Coordinator.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//

//import SwiftUI
//
//class Coordinator: ObservableObject {
//    @Published var navigationPath = [AnyView]()
//    
//    func push(view: AnyView) {
//        navigationPath.append(view)
//    }
//    
//    func pop() {
//        _ = navigationPath.popLast()
//    }
//    
//    func rootView() -> AnyView {
//        navigationPath.first ?? AnyView(EmptyView())
//    }
//}

//import SwiftUI
//
//class Coordinator: ObservableObject {
//    @Published var path = [AnyView]()  // Una pila de vistas para la navegación
//
//    func push(view: AnyView) {
//        path.append(view)  // Agregar la nueva vista a la pila
//    }
//    
//    func pop() {
//        path.removeLast()  // Volver a la vista anterior
//    }
//}

//struct CoordinatorView: View {
//    @EnvironmentObject var coordinator: Coordinator
//
//    var body: some View {
//        NavigationStack(path: $coordinator.path) {
//            VStack {
//                // Aquí va el contenido principal de la vista
//            }
//            .navigationDestination(for: AnyView.self) { view in
//                view  // Navegar hacia la vista pasada
//            }
//        }
//    }
//}

import SwiftUI

class Coordinator: ObservableObject {
    @Published var path = [AnyView]()  // Para la navegación por pila (push)
    @Published var modalView: AnyView? = nil  // Para la vista modal
    
    // Para la navegación por pila
    func push(view: AnyView) {
        path.append(view)  // Agregar la nueva vista a la pila
    }
    
    // Para volver a la vista anterior en la pila
    func pop() {
        path.removeLast()  // Volver a la vista anterior
    }
    
    // Para presentar una vista modal
    func presentModal(view: AnyView) {
        modalView = view  // Presentar la vista como modal
    }
    
    // Para cerrar la vista modal
    func dismissModal() {
        modalView = nil  // Cerrar la vista modal
    }
}
