//
//  LogInController.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

class LogInController: UIViewController {
    
    // MARK: - Properties
    let logInView = LogInView()
    let logInUserModel = LogInUesr()
    var activityIndicatorView : UIActivityIndicatorView!

    // MARK: - Helper Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        logInView.delegate = self
        view.addSubview(logInView)
        configureIndicatorView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logInView.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: view.frame.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right, height: view.frame.size.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
    }
    
    func configureIndicatorView() {
        
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
        activityIndicatorView.color = UIColor(red: 44/255, green: 169/255, blue: 225/255, alpha: 1)
        view.addSubview(activityIndicatorView)
        
    }

}

// MARK: - Delegate
extension LogInController: LogInViewDelegate {
    
    func toggleSignUpView() {
        navigationController?.popViewController(animated: true)
    }
    
    func logInUser(withEmail email: String, password: String) {
        activityIndicatorView.startAnimating()
        logInUserModel.logInUser(withEmail: email, password: password, errorMessage: {(errorMessage) in
            self.activityIndicatorView.stopAnimating()
            self.logInView.logInButton.isEnabled = true
            self.logInView.toggleSignUpViewButton.isEnabled = true
        UIViewController.noticeAlert(viewController: self, alertTitle: "メッセージ", alertMessage: errorMessage)
        }) {
            self.activityIndicatorView.stopAnimating()
            self.logInView.logInButton.isEnabled = true
            self.logInView.toggleSignUpViewButton.isEnabled = true
            self.logInUserModel.dicideNextViewController(ifError: {
                self.navigationController?.pushViewController(ConfirmEmailControllerInLogIn(), animated: true)
            }) {
                self.navigationController?.pushViewController(ContainerController(), animated: true)
            }
        }
    }
    
}
