//
//  UserManager.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 29/11/24.
//

import Foundation
import Combine
import SwiftUI
import FirebaseFirestore

class UserManager: ObservableObject {
    @Published var user: UserJSON?
    
    // Singleton instance
    static let shared = UserManager()
    
    private init() {}
    
    // Fetch user data (example)
    func fetchUserData(userID: String) {
        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot, snapshot.exists,
                  let user = try? snapshot.data(as: UserJSON.self) else {
                print("User not found.")
                return
            }
            
            DispatchQueue.main.async {
                self.user = user
            }
        }
    }
    
    // Update user profile image URL
    func updateProfileImageURL(_ url: String, userID: String) {
        let db = Firestore.firestore()
        db.collection("users").document(userID).updateData(["profileImageURL": url]) { error in
            if let error = error {
                print("Error updating Firestore: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.user?.profileImageURL = url
                }
            }
        }
    }
}
