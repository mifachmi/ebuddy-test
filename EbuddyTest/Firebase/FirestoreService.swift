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

