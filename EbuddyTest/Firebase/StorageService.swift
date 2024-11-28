//
//  StorageService.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 28/11/24.
//

import Foundation
import FirebaseStorage

let storage = Storage.storage()
let storageRef = storage.reference()

func uploadImage(imageData: Data) {
    let imagesRef = storageRef.child("images/example.jpg")
    imagesRef.putData(imageData, metadata: nil) { metadata, error in
        if let error = error {
            print("Error uploading image: \(error)")
        } else {
            print("Image uploaded successfully!")
        }
    }
}

