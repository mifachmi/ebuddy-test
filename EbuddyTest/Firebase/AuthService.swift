//
//  AuthService.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 28/11/24.
//

import Foundation
import FirebaseAuth

func signUp() {
    Auth.auth().createUser(withEmail: "user@example.com", password: "password123") { authResult, error in
        if let error = error {
            print("Error signing up: \(error)")
        } else {
            print("User signed up successfully!")
        }
    }
    
}

func signIn() {
    Auth.auth().signIn(withEmail: "user@example.com", password: "password123") { authResult, error in
        if let error = error {
            print("Error signing in: \(error)")
        } else {
            print("User signed in successfully!")
        }
    }
    
}
