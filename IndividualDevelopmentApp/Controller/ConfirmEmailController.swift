//
//  ConfirmEmailController.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

// 届いたメールのリンクを踏んだか確認するためのViewController
class ConfirmEmailController: UIViewController {
    
    // MARK: - Properties
    var confirmEmailView = ConfirmEmailView()
    var confirmEmailModel = SignUpUser()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        confirmEmailView.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: view.frame.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right, height: view.frame.size.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
    }
    
    // MARK: - Helper Functions
    func configureView() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        view.addSubview(confirmEmailView)
        confirmEmailView.delegate = self
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(confirmEmailWasVerified), userInfo: nil, repeats: true)
    }
    
    // MARK: - Selectors
    
    @objc func confirmEmailWasVerified() {
        
        confirmEmailModel.reloadCurrentUserInfo()
        
    }

}

// MARK: - Delagate
extension ConfirmEmailController: ConfirmEmailViewDelegate {

    func resendEmail() {
        confirmEmailModel.resendEmail {

            let alertController = UIAlertController(title: "メッセージ", message: "メールを送信しました", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func completedRegistration() {
        // この引数クロージャでトレイリングクロージャをすると意味不になりそうなのであえて使わない
        confirmEmailModel.goToMainContentView(ifError: {
            
            print("error..")
            let alertController = UIAlertController(title: "メッセージ", message: "本人確認が完了していません", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
        }, completion: {
            print("completed registration..")
//            self.navigationController?.pushViewController(CustomTabBarController(), animated: true)
            self.navigationController?.pushViewController(ContainerController(), animated: true)
        })
    }
    
}
