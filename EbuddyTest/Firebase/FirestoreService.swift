//
//  FirestoreService.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 28/11/24.
//

import Foundation
import FirebaseFirestore

let db = Firestore.firestore()

func addUser() {
    db.collection("users").addDocument(data: [
        "name": "Fachmi",
        "age": 25
    ]) { error in
        if let error = error {
            print("Error adding document: \(error)")
        } else {
            print("Document added successfully!")
        }
    }
}

func fetchUser(from documentID: String, completion: @escaping (Result<UserJSON, Error>) -> Void) {
    let db = Firestore.firestore()
    db.collection("users").document(documentID).getDocument { snapshot, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let snapshot = snapshot, snapshot.exists,
              let user = try? snapshot.data(as: UserJSON.self) else {
            completion(.failure(NSError(domain: "FirestoreError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
            return
        }
        
        completion(.success(user))
    }
}
