//
//  DataService.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 29/11/24.
//

import Foundation

protocol DataService {
    func fetchData() -> [String]
}

class MockDataService: DataService {
    func fetchData() -> [String] {
        return ["Mock Data 1", "Mock Data 2", "Mock Data 3"]
    }
}

class APIDataService: DataService {
    func fetchData() -> [String] {
        // Simulate a real network call
        return ["Real Data 1", "Real Data 2"]
    }
}

