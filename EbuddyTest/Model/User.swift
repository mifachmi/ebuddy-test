//
//  User.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 29/11/24.
//

import Foundation

enum GenderEnum: Int, Codable {
    case female = 0
    case male = 1
}

struct UserJSON: Codable {
    var uid: String?
    var email: String?
    var phoneNumber: String?
    var gender: GenderEnum?
    var profileImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case uid = "uid" // Map directly to Firestore field name
        case email = "email"
        case phoneNumber = "phone_number" // Example of mapping legacy keys
        case gender = "gender"
        case profileImageURL = "profile_image_url"
    }
}