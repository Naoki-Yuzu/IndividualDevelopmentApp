//
//  SignUpUser.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import Firebase

class SignUpUser {
    
    func authenticationUser() -> Bool {
        if Auth.auth().currentUser == nil {
            print("authentication user false")
            return false
        } else {
            print("authentication user true")
            return true
        }
    }
    
    func confirmEmailVerified() -> Bool {
        if Auth.auth().currentUser!.isEmailVerified {
            print("本登録完了済み")
            return true
        } else {
            print("本登録未完了")
            return false
        }
    }
    
    // ここクソむずいclosureむずい
    func signUpUser(withEmail email: String, password: String, errorMessage: @escaping (String) -> Void ,completion: @escaping () -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("error")
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    print(errCode.rawValue)
                    switch errCode {
                    case .invalidEmail:
                        errorMessage("メールアドレスの形式が違います")
                        print("メールアドレスの形式が違います")
                        break
                    case .emailAlreadyInUse:
                        errorMessage("このメールアドレスは既に使われています")
                        print("このメールアドレスは既に使われています")
                        break
                    case .weakPassword:
                        errorMessage("パスワードは6文字以上で入力してください")
                        print("パスワードは6文字以上で入力してください")
                        break
                    default:
                        break
                    }
                }
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
    func resendEmail(errorMessage: @escaping (String) -> Void ,completion: @escaping () -> Void) {
        
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            if error != nil {
                print(error!.localizedDescription)
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    print(errCode.rawValue)
                    switch errCode {
                    case .userNotFound:
                        errorMessage("ユーザーアカウントが見つかりません")
                        print("ユーザーアカウントが見つかりません")
                        break
                    default:
                        break
                    }
                }
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
