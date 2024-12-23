//
//  EbuddyTestApp.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 27/11/24.
//

import SwiftUI
import Firebase

@main
struct EbuddyTestApp: App {
    @State private var currentEnvironment: AppEnvironment = .development
    
    init() {
        FirebaseApp.configure()
        print("Firebase Initialized")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppConfiguration(environment: currentEnvironment))
                .environmentObject(UserManager.shared)
        }
    }
}
