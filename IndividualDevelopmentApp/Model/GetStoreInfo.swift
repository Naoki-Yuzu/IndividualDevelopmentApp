//
//  GetStoreInfo.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/03/05.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import Firebase

class GetStoreInfo {
    
    // MARK: - Properties
    let db = Firestore.firestore()
    
    // MARK: - Methods
    func getStoreInfo(ifError: @escaping () -> Void, completion: @escaping (_ snapShot: QuerySnapshot) -> Void) {
        let collRef = db.collection("Stores")
        collRef.getDocuments { [weak self] (snapShot, error) in
            if let _ = self {

                if error != nil {
                    ifError()
                    print("could not get store data..")
                } else {
                    guard let unwrappedSnapShot = snapShot else { return }
                    completion(unwrappedSnapShot)
                }

            }
            
        }
    }
    
//    func getPostUserInfo(userId: String, storeName: String, storeReview: String ,completion: @escaping  (_ snapShot: DocumentSnapshot) -> Void) {
//        print("getPostUserInfoメソッドだよ")
//        print(userId)
//        let docRef = db.collection("Users").document(userId)
//        print("ihihi")
//        docRef.getDocument { [weak self] (snapShot, error) in
//            if let _ = self {
//
//                print("クロージャに入ったよ")
//                guard let unwrappedSnapShot = snapShot else { return }
//                print("アンラップしたよ")
//                completion(unwrappedSnapShot)
//
//            }
//        }
//    }
    
    func getPostUserInfo(userId: String,completion: @escaping  (_ snapShot: DocumentSnapshot) -> Void) {
        print("getPostUserInfoメソッドだよ")
        print(userId)
        let docRef = db.collection("Users").document(userId)
        docRef.getDocument { [weak self] (snapShot, error) in
            if let _ = self {
                
                print("クロージャに入ったよ")
                guard let unwrappedSnapShot = snapShot else { return }
                print("アンラップしたよ")
                completion(unwrappedSnapShot)
                
            }
        }
    }
    
//    func postUserInfo() {
//
//        print("post user info..")
//        let docRef = db.collection("Stores")
//        docRef.getDocuments { (snapShot, error) in
//            if error != nil {
//                print("could not get store data..")
//            } else {
//                print("ahaha")
//                guard let unwrappedSnapShot = snapShot else { return }
//                print("uhehe")
//                for document in unwrappedSnapShot.documents {
//                    let storeData = document.data()
//                    guard let userId = storeData["userId"] as? String else { return }
//                    print("nyohoho")
//                    print(userId)
//                    let docRefUser = self.db.collection("Users")
//                    docRefUser.getDocuments { (snapShot2, error) in
//                        if error != nil {
//                            print("error..")
//                        } else {
//                            guard let unwrappedSnapShot2 = snapShot2 else { return }
//                            print("mohehe")
//                            for document in unwrappedSnapShot2.documents {
//                                print(document)
//                                let userData =
//                                "spKsAdVcgfMG3pt4f1cssdB71GK2"
//
//                                print("----------")
//                                print(userData)
//                                print("----------")
//                                print(userId)
//                                if userData == userId {
//                                    print("kitayo")
//                                    let userInfo = document.data()
//                                    guard let postUserName = userInfo["userName"] as? String, let postUserIcon = userInfo["userImage"] as? String else { return }
//                                    print("ukyokyo")
//                                    print(postUserName)
//                                    print(postUserIcon)
//                                } else {
//                                    return
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//
//    }

}
