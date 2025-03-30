//
//  PayphoneTestApp.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//

import SwiftUI

@main
struct PayphoneTestApp: App {
    @StateObject private var coordinator = Coordinator()
    var body: some Scene {
        WindowGroup {
            UserListView()
                .environmentObject(coordinator)
        }
    }
}
