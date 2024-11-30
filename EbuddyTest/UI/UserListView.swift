//
//  UserListView.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 30/11/24.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.users, id: \.self) { user in
                VStack(alignment: .leading) {
                    Text(user.email ?? "No Email")
                        .font(.headline)
                    Text("Rating: \(user.rating ?? 0.0, specifier: "%.1f")")
                    Text("Pricing: $\(user.servicePricing ?? 0.0, specifier: "%.2f")")
                    Text("Last Active: \(formattedDate(user.lastActive))")
                }
            }
            .navigationTitle("Users")
            .onAppear {
                viewModel.fetchUsers()
            }
        }
    }
    
    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    UserListView()
}
