//
//  UserProfileView.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 29/11/24.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject private var viewModel = UserProfileViewModel()
    @State private var isPickerPresented = false
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        VStack {
            if let user = userManager.user {
                if let profileImageURL = user.profileImageURL, let url = URL(string: profileImageURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                        case .failure:
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 150, height: 150)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 150, height: 150)
                }
                
                Text("UID: \(user.uid ?? "N/A")")
                Text("Email: \(user.email ?? "N/A")")
                Text("Phone: \(user.phoneNumber ?? "N/A")")
                Text("Gender: \(user.gender == .male ? "Male" : "Female")")
            } else {
                Text("Loading user...")
            }
        }
        .onAppear {
            userManager.fetchUserData(userID: "userDocumentID") // Replace with actual user ID
        }
    }
}

#Preview {
    UserProfileView()
        .environmentObject(UserManager.shared)
}
