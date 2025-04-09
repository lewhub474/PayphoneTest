//
//  Coordinator.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//

import SwiftUI

class Coordinator: ObservableObject {
    @Published var path = [AnyView]()
    @Published var modalView: AnyView? = nil
    
  
    func push(view: AnyView) {
        path.append(view)
    }
    
   
    func pop() {
        path.removeLast()
    
   
    func presentModal(view: AnyView) {
        modalView = view  /
    }
   
    func dismissModal() {
        modalView = nil  
    }
}
