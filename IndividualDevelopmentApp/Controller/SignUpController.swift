//
//  SignUpController.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    
    // MARK: - Properties
    let signUpView = SignUpView()
    let signUpUserModel = SignUpUser()
    var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Helper Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        print("sign up controller..")
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        view.addSubview(signUpView)
        signUpView.delegate = self
        configureIndicatorView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signUpView.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: view.frame.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right, height: view.frame.size.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
    }
    
    func configureIndicatorView() {
        
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
        activityIndicatorView.color = UIColor(red: 44/255, green: 169/255, blue: 225/255, alpha: 1)
        view.addSubview(activityIndicatorView)
        
    }

}

// MARK: - Delegate
extension SignUpController: SignUpViewDelegate {
    
    func togglelogInView() {
        navigationController?.pushViewController(LogInController(), animated: true)
    }
    
    func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
        
    }
    
    func signUpUser(withEmail email: String, password: String) {
        
        activityIndicatorView.startAnimating()
        print("while sign up")
        // パターン1 トレイリングクロージャ使う
        signUpUserModel.signUpUser(withEmail: email, password: password, errorMessage: { (errorMessage) in
            self.activityIndicatorView.stopAnimating()
            UIViewController.noticeAlert(viewController: self, alertTitle: "メッセージ", alertMessage: errorMessage)
            self.signUpView.toggleLoginViewButton.isEnabled = true
            self.signUpView.registerButton.isEnabled = true
        }) {
            self.signUpUserModel.sendEmail() {
        
            print("sent email..")
                self.activityIndicatorView.stopAnimating()
            self.navigationController?.pushViewController(ConfirmEmailController(), animated: true)
                self.signUpView.toggleLoginViewButton.isEnabled = true
                self.signUpView.registerButton.isEnabled = true
            }
        }
    }
        
        /* パターン2 トレイリングクロージャ使わない
        signUpUserModel.signUpUser(withEmail: email, password: password, completion: {self.dismiss(animated: true, completion: nil)})
        */
        
}

    

