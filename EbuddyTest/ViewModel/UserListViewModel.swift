//
//  UserListViewModel.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 30/11/24.
//

import Foundation
import Combine
import FirebaseFirestore

class UserListViewModel: ObservableObject {
    @Published var users: [UserJSON] = []
    private var cancellables = Set<AnyCancellable>()
    
    private let db = Firestore.firestore()
    
    // Fetch users with multiple queries
    func fetchUsers() {
        // Query 1: Recently active (descending order)
        let query1 = db.collection("users")
            .order(by: "lastActive", descending: true)
        
        // Query 2: Highest rating (descending order)
        let query2 = db.collection("users")
            .order(by: "rating", descending: true)
        
        // Query 3: Is Female
        let query3 = db.collection("users")
            .whereField("gender", isEqualTo: GenderEnum.female.rawValue)
        
        // Query 4: Lowest service pricing (ascending order)
        let query4 = db.collection("users")
            .order(by: "servicePricing")
        
        // Combine results
        Publishers.Zip4(
            queryToPublisher(query1),
            queryToPublisher(query2),
            queryToPublisher(query3),
            queryToPublisher(query4)
        )
        .map { query1Results, query2Results, query3Results, query4Results in
            // Merge all results (removing duplicates)
            let allResults = query1Results + query2Results + query3Results + query4Results
            return Array(Set(allResults)) // Ensure unique results
        }
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching users: \(error.localizedDescription)")
                }
            },
            receiveValue: { [weak self] users in
                self?.users = users
            }
        )
        .store(in: &cancellables)
    }
    
    // Helper function to convert Firestore queries to Combine publishers
    private func queryToPublisher(_ query: Query) -> AnyPublisher<[UserJSON], Error> {
        Future<[UserJSON], Error> { promise in
            query.getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else if let snapshot = snapshot {
                    let users = snapshot.documents.compactMap { document -> UserJSON? in
                        try? document.data(as: UserJSON.self)
                    }
                    promise(.success(users))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
