//
//  RestaurantManegerInFirebsae.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/03/13.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import Firebase

class RestaurantManegerInFirebsae {
    
    // MARK: - Properties
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference(forURL: "gs://individualdevelopmentapp-aa9c9.appspot.com")
    
    // MARK: - Methods
    func CurrentUserAndPostUserIsEquel(withUserID userId: String) -> Bool {
        guard let currentUser = Auth.auth().currentUser else { return false }
        if userId == currentUser.uid {
            print("true..")
            return true
        } else {
            print("false..")
            return false
        }
    }
    
    
    func deleteRestaurant(withStoreName documentName: String, ifErrorMessage: @escaping (String) -> Void, completion: @escaping () -> Void) {
        db.collection("Stores").document("\(documentName)").delete { [weak self] (error) in
            guard let self = self else { return }
            if error == nil {
                let userId = Auth.auth().currentUser?.uid
                self.storageRef.child("stores").child("\(userId!)").child("\(documentName).jpg").delete { [weak self] (storageError) in
                    guard let _ = self else { return }
                    if storageError == nil {
                        completion()
                    } else {
                        ifErrorMessage("データを削除できませんでした")
                    }
                }
            } else {
                ifErrorMessage("データを削除できませんでした")
            }
        }
    }
    
}
