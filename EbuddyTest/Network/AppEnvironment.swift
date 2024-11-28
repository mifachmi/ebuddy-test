//
//  AppEnvironment.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 28/11/24.
//

import Foundation

enum AppEnvironment {
    case development
    case staging
    case production
    
    var baseURL: URL {
        switch self {
        case .development: return URL(string: "https://dev.example.com")!
        case .staging: return URL(string: "https://staging.example.com")!
        case .production: return URL(string: "https://api.example.com")!
        }
    }
}
