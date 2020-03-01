//
//  LogInView.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol LogInViewDelegate {
    func toggleSignUpView()
    
    func logInUser(withEmail email: String, password: String)
}

class LogInView: UIView {
    
    // MARK: - Properties
    var titleLabel: UILabel!
    var emailLabel: UILabel!
    var emailTextFeild: UITextField!
    var passwordLabel: UILabel!
    var passwordTextField: UITextField!
    var conformPasswordTextFeild: UITextField!
    var logInButton: UIButton!
    var showOrHidePasswordButton: UIButton!
    var promptToSignUpLabel: UILabel!
    var toggleSignUpViewButton: UIButton!
    
    var delegate: LogInViewDelegate?
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        self.backgroundColor = .white
            
        titleLabel = OriginalLabel(textOfLabel: "ログイン", textColor: .black, fontAndSize: UIFont.boldSystemFont(ofSize: 20))
        titleLabel.textAlignment = .center
            
        emailLabel = OriginalLabel(textOfLabel: "メールアドレス", textColor: .black, fontAndSize: UIFont.boldSystemFont(ofSize: 10))
            
        emailTextFeild = OriginalTextField(placeholderText: "example@gmail.com", textColor: .black, keybordType: .emailAddress)
        emailTextFeild.delegate = self
        emailTextFeild.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 1)
            
        passwordLabel = OriginalLabel(textOfLabel: "パスワード", textColor: .black, fontAndSize: UIFont.boldSystemFont(ofSize: 10))
            
        passwordTextField = OriginalTextField(placeholderText: "半角英数字6文字以上", textColor: .black)
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 1)
            
        logInButton = OriginalButton(title: "ログイン", titleColor: .white, fontAndSize: UIFont.systemFont(ofSize: 15), backgroundColor: UIColor(red: 0/255, green: 128/255, blue: 128/255, alpha: 1))
        logInButton.addTarget(self, action: #selector(logInUser), for: .touchUpInside)
        
        promptToSignUpLabel = OriginalLabel(textOfLabel: "まだアカウントを持っていない方", textColor: .black, fontAndSize: UIFont.systemFont(ofSize: 11))
            
        toggleSignUpViewButton = OriginalButton(title: "新規登録", titleColor: UIColor(red: 65/255, green: 105/255, blue: 225/255, alpha: 1), fontAndSize: .boldSystemFont(ofSize: 11))
        toggleSignUpViewButton.addTarget(self, action: #selector(toggleLogInView), for: .touchUpInside)
            
        // SignupViewのsubviewとして追加
        self.addSubview(titleLabel)
        self.addSubview(emailLabel)
        self.addSubview(emailTextFeild)
        self.addSubview(passwordLabel)
        self.addSubview(passwordTextField)
        self.addSubview(logInButton)
        self.addSubview(promptToSignUpLabel)
        self.addSubview(toggleSignUpViewButton)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    // MARK: - Helper Functions
    override func updateConstraints() {
        super.updateConstraints()
            
        // subviewのautoLayout設定
        // 長すぎるので改善したい
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextFeild.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        promptToSignUpLabel.translatesAutoresizingMaskIntoConstraints = false
        toggleSignUpViewButton.translatesAutoresizingMaskIntoConstraints = false
            
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
            
        emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        emailLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emailLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        emailLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.02).isActive = true
            
        emailTextFeild.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5).isActive = true
        emailTextFeild.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emailTextFeild.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        emailTextFeild.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
            
        passwordLabel.topAnchor.constraint(equalTo: emailTextFeild.bottomAnchor, constant: 20).isActive = true
        passwordLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        passwordLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        passwordLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.02).isActive = true
            
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
            
        logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50).isActive = true
        logInButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
        logInButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        logInButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
            
        promptToSignUpLabel.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        promptToSignUpLabel.trailingAnchor.constraint(equalTo: toggleSignUpViewButton.leadingAnchor, constant: -10).isActive = true
        promptToSignUpLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        promptToSignUpLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.02).isActive = true
            
        toggleSignUpViewButton.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        toggleSignUpViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60).isActive = true
        toggleSignUpViewButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        toggleSignUpViewButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.03).isActive = true
    }

}

// MARK: - Delegate
extension LogInView: UITextFieldDelegate {
        
    // リターンキーがタップされたらキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
        
}

extension LogInView {
        
    // textField以外をタップしたらキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // endEditingメソッドでもキーボードを閉じることができる
        self.endEditing(true)
    }
    
}

// MARK: - Selectors
extension LogInView {
    
    // toggleSignUpViewButtonがタップされたら呼ばれるメソッド
    @objc func toggleLogInView() {
        
        delegate?.toggleSignUpView()
        
    }
    
    @objc func logInUser() {
        
        delegate?.logInUser(withEmail: emailTextFeild.text!, password: passwordTextField.text!)
        
    }
    
}
