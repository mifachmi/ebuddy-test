//
//  UsersView.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 29/11/24.
//

import SwiftUI

struct UsersView: View {
    @State private var user: UserJSON?
    
    var body: some View {
        VStack {
            if let user = user {
                Text("UID: \(user.uid ?? "N/A")")
                Text("Email: \(user.email ?? "N/A")")
                Text("Phone: \(user.phoneNumber ?? "N/A")")
                Text("Gender: \(user.gender == .male ? "Male" : "Female")")
            } else {
                Text("Loading user...")
            }
        }
        .onAppear {
            fetchUser(from: "userDocumentID") { result in
                switch result {
                case .success(let fetchedUser):
                    user = fetchedUser
                case .failure(let error):
                    print("Error fetching user: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    UsersView()
}
