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
    var activityIndicatorView: UIActivityIndicatorView!
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureIndicatorView()
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
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(confirmEmailWasVerified), userInfo: nil, repeats: true)
    }

    func configureIndicatorView() {
        
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
        activityIndicatorView.color = UIColor(red: 44/255, green: 169/255, blue: 225/255, alpha: 1)
        view.addSubview(activityIndicatorView)
        
    }
    
    // MARK: - Selectors
    
    @objc func confirmEmailWasVerified() {
        
        confirmEmailModel.reloadCurrentUserInfo()
        
    }

}

// MARK: - Delagate
extension ConfirmEmailController: ConfirmEmailViewDelegate {

    func resendEmail() {
        activityIndicatorView.startAnimating()
        confirmEmailModel.resendEmail(errorMessage: {(errorMessage) in
            self.activityIndicatorView.stopAnimating()
            self.confirmEmailView.resendEmailButton.isEnabled = true
            self.confirmEmailView.completedRegistrationButton.isEnabled = true
            UIViewController.noticeAlert(viewController: self, alertTitle: "メッセージ", alertMessage: errorMessage)
        }) {
            
            self.activityIndicatorView.stopAnimating()
            self.confirmEmailView.resendEmailButton.isEnabled = true
            self.confirmEmailView.completedRegistrationButton.isEnabled = true
            let alertController = UIAlertController(title: "メッセージ", message: "メールを送信しました", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func completedRegistration() {
        activityIndicatorView.startAnimating()
        // この引数クロージャでトレイリングクロージャをすると意味不になりそうなのであえて使わない
        confirmEmailModel.goToMainContentView(ifError: {
            
            print("error..")
            self.activityIndicatorView.stopAnimating()
            self.confirmEmailView.resendEmailButton.isEnabled = true
            self.confirmEmailView.completedRegistrationButton.isEnabled = true
            let alertController = UIAlertController(title: "メッセージ", message: "本人確認が完了していません", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
        }, completion: {
            print("completed registration..")
            self.timer.invalidate()
            self.activityIndicatorView.stopAnimating()
            self.confirmEmailView.resendEmailButton.isEnabled = true
            self.confirmEmailView.completedRegistrationButton.isEnabled = true
            self.navigationController?.pushViewController(ContainerController(), animated: true)
        })
    }
    
}
