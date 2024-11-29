//
//  UserProfileViewModel.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 29/11/24.
//

import Foundation
import Combine
import FirebaseFirestore
import UIKit

class UserProfileViewModel: ObservableObject {
    @Published var user: UserJSON?
    @Published var profileImage: UIImage?
    @Published var uploadProgress: Double = 0.0

    private var cancellables = Set<AnyCancellable>()
    private let userID = "userDocumentID" // Replace with actual user ID

    init() {
        fetchUserData()
    }

    // Fetch user data from Firestore
    func fetchUserData() {
        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
                return
            }

            guard let snapshot = snapshot, snapshot.exists,
                  let user = try? snapshot.data(as: UserJSON.self) else {
                print("User not found.")
                return
            }

            DispatchQueue.main.async {
                self.user = user
                if let urlString = user.profileImageURL, let url = URL(string: urlString) {
                    self.loadImage(from: url)
                }
            }
        }
    }

    // Load profile image
    private func loadImage(from url: URL) {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$profileImage)
    }

    // Upload profile image in the background
    func uploadProfileImage(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }

        let uploadTask = UploadTaskManager.shared.upload(
            imageData: imageData,
            toPath: "profile_images/\(userID).jpg"
        )

        uploadTask
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error during upload: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] url in
                self?.updateUserProfileImageURL(url)
            })
            .store(in: &cancellables)
    }

    // Update Firestore with the image URL
    private func updateUserProfileImageURL(_ url: String) {
        let db = Firestore.firestore()
        db.collection("users").document(userID).updateData(["profileImageURL": url]) { error in
            if let error = error {
                print("Error updating Firestore: \(error.localizedDescription)")
            }
        }
    }
}
