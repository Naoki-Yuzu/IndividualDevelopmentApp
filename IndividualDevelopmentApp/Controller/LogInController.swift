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

    // MARK: - Helper Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        logInView.delegate = self
        view.addSubview(logInView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logInView.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: view.frame.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right, height: view.frame.size.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
    }

}

// MARK: - Delegate
extension LogInController: LogInViewDelegate {
    
    func toggleSignUpView() {
        navigationController?.popViewController(animated: true)
    }
    
    func logInUser(withEmail email: String, password: String) {
        logInUserModel.logInUser(withEmail: email, password: password) {
//            self.navigationController?.pushViewController(CustomTabBarController(), animated: true)
            self.navigationController?.pushViewController(ContainerController(), animated: true)
        }
    }
    
}
