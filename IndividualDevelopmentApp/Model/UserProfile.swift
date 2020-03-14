//
//  UserProfile.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import Firebase

class UserProfile {
    
    let metaData = StorageMetadata()
    let storageRef = Storage.storage().reference(forURL: "gs://individualdevelopmentapp-aa9c9.appspot.com")
    lazy var userProfileImageFolder = storageRef.child("users")
    var userProfileImageFile: StorageReference!
    var stringOfURL: String!
    let db = Firestore.firestore()
    
    // ユーザーのアイコン画像をstorageに保存してURLをダウンロードするメソッド
    func uploadUserProfileImage(withUIImage image: UIImage, completion: @escaping () -> Void) {
        
        guard let user = Auth.auth().currentUser else { return }
        guard let uploadData = image.jpegData(compressionQuality: 0.9) else { return }
        
        userProfileImageFile = userProfileImageFolder.child("\(user.uid).jpg")
        print(userProfileImageFile as Any)
        metaData.contentType = "image/jpg"
        
        // 画像をアップロード
        userProfileImageFile.putData(uploadData, metadata: metaData) { (_, error) in
            
            guard error == nil else { return }
            print("No error..")
            // 画像をダウンロード
            self.userProfileImageFile.downloadURL { (url, error) in
                
                guard error == nil else { return }
                guard let url = url else { return }
                print("downloaded URL..")
                self.stringOfURL = url.absoluteString
                
                print(self.stringOfURL as Any)
                completion()
            }
        }
        
    }
    
    // ユーザーのアイコン画像のURLと名前をCloudFirestoreに保存するメソッド
    func registerUserInfo(withUserName name: String, userImage: String, completion: @escaping ()-> Void) {
        
        guard let user = Auth.auth().currentUser else { return }
        db.collection("Users").document("\(user.uid)").setData([
            "userName": name,
            "userImage": userImage
        ], merge: true) { (error) in
            if error != nil {
                print("error..")
            } else {
                print("completed..")
                completion()
            }
        }
      
    }
    
    // ユーザーのアイコン画像と名前を取得するメソッド
    func getUserInfo(completion: @escaping (_ document: DocumentSnapshot) -> Void) {
        
        guard let user = Auth.auth().currentUser else { return }
        db.collection("Users").document("\(user.uid)").getDocument { (document, error) in
            guard error == nil else { return }
            guard let unwrappedDocument = document else { return }
            print("unwrapped user information..")
            completion(unwrappedDocument)
        }
    }
    
}
