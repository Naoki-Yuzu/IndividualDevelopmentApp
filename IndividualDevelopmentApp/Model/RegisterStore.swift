//
//  RegisterStore.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/03/02.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import Firebase

class RegisterStore {
    
    // MARK: - Properties
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference(forURL: "gs://individualdevelopmentapp-aa9c9.appspot.com")
    let metaData = StorageMetadata()
    var userId: String!
    lazy var storeImageFolder = storageRef.child("stores").child("\(userId!)")
    
    // MARK: - Methods
    func registerStrore(storeImage: UIImage, storeName: String, storeImpression: String, longitude: Double, latitude: Double, completion: @escaping () -> Void) {
        
        guard let user = Auth.auth().currentUser else { return }
        userId = user.uid
        guard let uploadData = storeImage.jpegData(compressionQuality: 0.9) else { return }
        
        metaData.contentType = "image/jpg"
        
        // 画像をstorageに保存
        let storeImageFile = storeImageFolder.child("\(storeName).jpg")
        storeImageFile.putData(uploadData, metadata: metaData) { (metaData, error) in
            
            guard error == nil else { return }
            print("uploaded store image..")
            
            // 画像のURLをダウンロード
            storeImageFile.downloadURL { (url, error) in
                
                guard error == nil else { return }
                guard let url = url else { return }
                print("downloaded store URL..")
                
                // 使い方が不明ンゴ
               /* self.db.collection("Stores").document("\(self.userId!)").collection("\(storeName)").setValuesForKeys([
                    "storeName": storeName,
                    "storeImage": url.absoluteString,
                    "storeImpression": storeImpression,
                    "longitude": longitude,
                    "latitude": latitude
                ])
                */
                
//                self.db.collection("Stores").document("\(self.userId!)").collection("store").document("\(storeName)").setData([
//                    "storeName": storeName,
//                    "storeImage": url.absoluteString,
//                    "storeImpression": storeImpression,
//                    "longitude": longitude,
//                    "latitude": latitude
//                ], merge: true) { (error) in
//                    guard error == nil else { return }
//                    completion()
//                }
                
                self.db.collection("Stores").document("\(storeName)").setData([
                    "userId": self.userId!,
                    "storeName": storeName,
                    "storeImage": url.absoluteString,
                    "storeImpression": storeImpression,
                    "longitude": longitude,
                    "latitude": latitude,
                    "createdAt": FieldValue.serverTimestamp(),
                    "apdateedAt": FieldValue.serverTimestamp()
                ], merge: true) { (error) in
                    guard error == nil else { return }
                    completion()
                }

                
            }
            
        }
        
    }
    
}
