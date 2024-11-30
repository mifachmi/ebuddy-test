//
//  UploadTaskManager.swift
//  EbuddyTest
//
//  Created by Fachmi Dimas Ardhana on 29/11/24.
//

import Foundation
import Combine
import FirebaseStorage

class UploadTaskManager {
    static let shared = UploadTaskManager()

    func upload(imageData: Data, toPath path: String) -> AnyPublisher<String, Error> {
        let storageRef = Storage.storage().reference().child(path)
        let subject = PassthroughSubject<String, Error>()

        let task = storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }

            storageRef.downloadURL { url, error in
                if let error = error {
                    subject.send(completion: .failure(error))
                } else if let url = url {
                    subject.send(url.absoluteString)
                    subject.send(completion: .finished)
                }
            }
        }

        // Observe upload progress
        task.observe(.progress) { snapshot in
            let progress = Double(snapshot.progress?.fractionCompleted ?? 0)
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .uploadProgress, object: progress)
            }
        }

        return subject.eraseToAnyPublisher()
    }
}

extension Notification.Name {
    static let uploadProgress = Notification.Name("uploadProgress")
}
