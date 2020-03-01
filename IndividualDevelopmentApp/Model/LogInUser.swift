//
//  LogInUser.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import Firebase

class LogInUesr {
    
    func logInUser(withEmail email: String, password: String , completion: @escaping () -> Void) {
        
        print("tapped log in..")
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("error")
            } else {
                print("did log in..")
                // ログインが完了したら画面遷移をするための引数クロージャ
                completion()
            }
        }
        
    }

}
