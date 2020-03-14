//
//  DeleteUserAccount.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/03/14.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import Firebase

class DeleteUserAccount {
    
    // MARK: - Properties
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference(forURL: "gs://individualdevelopmentapp-aa9c9.appspot.com")
    
    // MARK: - Methods
    func deleteUser(errorMessage: @escaping (String) -> Void ,completion: @escaping () -> Void) {
        guard let user = Auth.auth().currentUser else { return }
        
        let userProfileImageFile = storageRef.child("users").child("\(user.uid).jpg")
        let uploadData = UIImage(named: "profile_icon")?.jpegData(compressionQuality: 0.1)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"

        guard let unwappedUploadData = uploadData else { return }

        userProfileImageFile.putData(unwappedUploadData, metadata: metaData) { (_, error) in
            guard error == nil else { return }
            userProfileImageFile.downloadURL { (url, error) in
                guard error == nil else { return }
                guard let url = url else { return }
                let stringURL = url.absoluteString
                self.db.collection("Users").document("\(user.uid)").setData([
                    "userName": "退会済みユーザー",
                    "userImage": stringURL
                ], merge: true) { (error) in
                        guard error == nil else { return }
                        user.delete { (error) in
                            if error == nil {
                                completion()
                            } else {
                                if let errCode = AuthErrorCode(rawValue: error!._code) {
                                    switch errCode {
                                    case .requiresRecentLogin:
                                        errorMessage("一度ログアウトをした後、再度ログインしてからアカウントを削除してください。")
                                        break
                                    default:
                                        errorMessage("原因不明のエラーです")
                                        break
                                    }
                                }
                            }
                        }
                }
            }
        }
    }
    
}
