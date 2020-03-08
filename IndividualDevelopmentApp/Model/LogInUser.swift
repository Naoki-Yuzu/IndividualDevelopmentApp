//
//  LogInUser.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import Firebase

class LogInUesr {
    
    func logInUser(withEmail email: String, password: String , errorMessage: @escaping (String) -> Void , completion: @escaping () -> Void) {
        
        print("tapped log in..")
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("error")
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    print(errCode.rawValue)
                    switch errCode {
                    case .invalidEmail:
                        errorMessage("メールアドレスの形式が違います")
                        print("メールアドレスの形式が違います")
                        break
                    case .wrongPassword:
                        errorMessage("パスワードが違います")
                        print("パスワードが違います")
                        break
                    case .userDisabled:
                        errorMessage("ユーザーのアカウントが無効になっています")
                        print("ユーザーのアカウントが無効になっています")
                        break
                    case .userNotFound:
                        errorMessage("ユーザーアカウントが見つかりません")
                        print("ユーザーアカウントが見つかりません")
                        break
                    default:
                        errorMessage("原因不明のエラーです")
                        break
                    }
                }
            } else {
                print("did log in..")
                // ログインが完了したら画面遷移をするための引数クロージャ
                completion()
            }
        }
        
    }
    
    func dicideNextViewController(ifError error: @escaping () ->Void ,completion: @escaping () -> Void) {
        
        if Auth.auth().currentUser!.isEmailVerified {
            completion()
        } else {
            error()
        }
        
    }

}
