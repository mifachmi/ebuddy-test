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
    
    var body: some View {
        VStack {
            if let profileImage = viewModel.profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
            } else {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 150, height: 150)
            }
            
            Button("Change Profile Image") {
                isPickerPresented = true
            }
            .sheet(isPresented: $isPickerPresented) {
                ImagePickerView(selectedImage: $viewModel.profileImage)
            }
            
            if let user = viewModel.user {
                Text("UID: \(user.uid ?? "N/A")")
                Text("Email: \(user.email ?? "N/A")")
                Text("Phone: \(user.phoneNumber ?? "N/A")")
                Text("Gender: \(user.gender == .male ? "Male" : "Female")")
            } else {
                Text("Loading user...")
            }
            
            ProgressView(value: viewModel.uploadProgress)
                .padding()
        }
        .onReceive(NotificationCenter.default.publisher(for: .uploadProgress)) { notification in
            if let progress = notification.object as? Double {
                viewModel.uploadProgress = progress
            }
        }
    }
}

#Preview {
    UserProfileView()
}
