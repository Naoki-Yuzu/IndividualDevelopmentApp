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
    func getStoreInfo(completion: @escaping (_ snapShot: QuerySnapshot) -> Void) {
        let docRef = db.collection("Stores")
        docRef.getDocuments { (snapShot, error) in
            if error != nil {
                print("could not get store data..")
            } else {
                guard let unwrappedSnapShot = snapShot else { return }
                completion(unwrappedSnapShot)
            }
        }
    }

}
