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
    
    init() {
        FirebaseApp.configure()
        print("Firebase Initialized")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
