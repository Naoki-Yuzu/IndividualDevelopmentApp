//
//  SignUpUser.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import Firebase

class SignUpUser {
    
    // ここクソむずいclosureむずい
    func signUpUser(withEmail email: String, password: String, completion: @escaping () -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("error")
            } else {
                
                print("did sign up..")
                // 新規登録が完了したら画面遷移をするための引数クロージャ
                completion()
                
            }
            
        }
        
    }
    
    func sendEmail(completion: @escaping () -> Void) {
        
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            if error != nil {
                print("error")
            } else {
                completion()
            }
        })
        
    }
    
    // 本人確認用のメールを再送信するメソッド
    func resendEmail(completion: @escaping () -> Void) {
        
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("sent email..")
                completion()
            }
        })
        
        
    }
    
    // 本人確認を終えたユーザーを次の画面に遷移せさせるメソッド
    func goToMainContentView(ifError error: @escaping () ->Void ,completion: @escaping () -> Void) {
        
        if Auth.auth().currentUser!.isEmailVerified {
            completion()
        } else {
            error()
        }
        
    }
    
    func reloadCurrentUserInfo() {
        
        print(Auth.auth().currentUser?.isEmailVerified as Any)
        Auth.auth().currentUser?.reload(completion: nil)
        
    }
    
}
