//
//  SignUpView.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol SignUpViewDelegate {
    
    func togglelogInView()
    
    func showAlert(title: String, message: String)
    
    func signUpUser(withEmail email: String, password: String)
    
}

class SignUpView: UIView {
    
    // MARK: - Properties
    var titleLabel: UILabel!
    var emailLabel: UILabel!
    var emailTextFeild: UITextField!
    var promptAttentionLabel: UILabel!
    var passwordLabel: UILabel!
    var passwordTextField: UITextField!
    var conformPasswordTextFeild: UITextField!
    var registerButton: UIButton!
    var showOrHidePasswordButton: UIButton!
    var promptTologInLabel: UILabel!
    var toggleLoginViewButton: UIButton!
    
    var delegate: SignUpViewDelegate?
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        titleLabel = OriginalLabel(textOfLabel: "新規登録", textColor: .black, fontAndSize: UIFont.boldSystemFont(ofSize: 20))
        titleLabel.textAlignment = .center
        
        emailLabel = OriginalLabel(textOfLabel: "メールアドレス", textColor: .black, fontAndSize: UIFont.boldSystemFont(ofSize: 10))
        
        emailTextFeild = OriginalTextField(placeholderText: "example@gmail.com", textColor: .black, keybordType: .emailAddress)
        emailTextFeild.delegate = self
        emailTextFeild.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 1)
        
        promptAttentionLabel = OriginalLabel(textOfLabel: "※登録完了後、ご本人様確認用のメールが届きます。", textColor: .darkGray, fontAndSize: .systemFont(ofSize: 10))
        
        passwordLabel = OriginalLabel(textOfLabel: "パスワード", textColor: .black, fontAndSize: UIFont.boldSystemFont(ofSize: 10))
        
        passwordTextField = OriginalTextField(placeholderText: "半角英数字6文字以上", textColor: .black)
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 1)

        conformPasswordTextFeild = OriginalTextField(placeholderText: "確認", textColor: .black)
        conformPasswordTextFeild.delegate = self
        conformPasswordTextFeild.isSecureTextEntry = true
        conformPasswordTextFeild.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 1)
        
        registerButton = OriginalButton(title: "登録", titleColor: .white, fontAndSize: UIFont.systemFont(ofSize: 15), backgroundColor: UIColor(red: 0/255, green: 128/255, blue: 128/255, alpha: 1))
        registerButton.addTarget(self, action: #selector(signUpUser), for: .touchUpInside)
        
        showOrHidePasswordButton = OriginalButton(image: UIImage(named: "eye-show-2")!)
        showOrHidePasswordButton.addTarget(self, action: #selector(showOrHidePassword), for: .touchUpInside)
        
        promptTologInLabel = OriginalLabel(textOfLabel: "既にアカウントを持っている方", textColor: .black, fontAndSize: UIFont.systemFont(ofSize: 11))
        
        toggleLoginViewButton = OriginalButton(title: "ログイン", titleColor: UIColor(red: 65/255, green: 105/255, blue: 225/255, alpha: 1), fontAndSize: .boldSystemFont(ofSize: 11))
        toggleLoginViewButton.addTarget(self, action: #selector(toggleLogInView), for: .touchUpInside)
        
        // SignupViewのsubviewとして追加
        self.addSubview(titleLabel)
        self.addSubview(emailLabel)
        self.addSubview(emailTextFeild)
        self.addSubview(promptAttentionLabel)
        self.addSubview(passwordLabel)
        self.addSubview(passwordTextField)
        self.addSubview(conformPasswordTextFeild)
        self.addSubview(registerButton)
        self.addSubview(showOrHidePasswordButton)
        self.addSubview(promptTologInLabel)
        self.addSubview(toggleLoginViewButton)
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
        promptAttentionLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        conformPasswordTextFeild.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        showOrHidePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        promptTologInLabel.translatesAutoresizingMaskIntoConstraints = false
        toggleLoginViewButton.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        promptAttentionLabel.topAnchor.constraint(equalTo: emailTextFeild.bottomAnchor, constant: 5).isActive = true
        promptAttentionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        promptAttentionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        promptAttentionLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.02).isActive = true
        
        passwordLabel.topAnchor.constraint(equalTo: promptAttentionLabel.bottomAnchor, constant: 20).isActive = true
        passwordLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        passwordLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        passwordLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.02).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        
        conformPasswordTextFeild.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5).isActive = true
        conformPasswordTextFeild.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        conformPasswordTextFeild.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        conformPasswordTextFeild.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        
        registerButton.topAnchor.constraint(equalTo: conformPasswordTextFeild.bottomAnchor, constant: 50).isActive = true
        registerButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
        registerButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        registerButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        
        showOrHidePasswordButton.centerYAnchor.constraint(equalTo: conformPasswordTextFeild.centerYAnchor).isActive = true
        showOrHidePasswordButton.leadingAnchor.constraint(equalTo: conformPasswordTextFeild.trailingAnchor, constant: 5).isActive = true
        showOrHidePasswordButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.07).isActive = true
        showOrHidePasswordButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        
        promptTologInLabel.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        promptTologInLabel.trailingAnchor.constraint(equalTo: toggleLoginViewButton.leadingAnchor, constant: -10).isActive = true
        promptTologInLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        promptTologInLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.02).isActive = true
        
        toggleLoginViewButton.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        toggleLoginViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60).isActive = true
        toggleLoginViewButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        toggleLoginViewButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.03).isActive = true
    }

}

// MARK: - Delegate
extension SignUpView: UITextFieldDelegate {
    
    // リターンキーがタップされたらキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

extension SignUpView {
    
    // textField以外をタップしたらキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // endEditingメソッドでもキーボードを閉じることができる
        self.endEditing(true)
    }
    
}

// MARK: - Selectors
extension SignUpView {
    
    @objc func signUpUser() {
        
        if enteredEmail() && conformSamePassword() {
            
            print("entered email and password")
            registerButton.isEnabled = false
            toggleLoginViewButton.isEnabled = false
            delegate?.signUpUser(withEmail: emailTextFeild.text!, password: passwordTextField.text!)
            
        }
        
    }
    
    // showOrHidePasswordButtonがタップされたら呼ばれるメソッド
    @objc func showOrHidePassword() {
        
        if passwordTextField.isSecureTextEntry && conformPasswordTextFeild.isSecureTextEntry {
            
            // パスワード表示&アイコン切り替え
            showOrHidePasswordButton.setImage(UIImage(named: "eye-hide-2"), for: .normal)
            passwordTextField.isSecureTextEntry = false
            conformPasswordTextFeild.isSecureTextEntry = false
            
        } else {
            
            // パスワード非表示&アイコン切り替え
            showOrHidePasswordButton.setImage(UIImage(named: "eye-show-2"), for: .normal)
            passwordTextField.isSecureTextEntry = true
            conformPasswordTextFeild.isSecureTextEntry = true
            
        }
        
    }
    
    // toggleLoginViewButtonがタップされたら呼ばれるメソッド
    @objc func toggleLogInView() {
        
        delegate?.togglelogInView()
        
    }
    
}

// MARK: - Helper Functions
extension SignUpView {
    
    func conformSamePassword() -> Bool{
        
        // パスワードがnilではないか確認
        if passwordTextField.text == nil || conformPasswordTextFeild.text == nil {
            return false
        }
        
        // パスワードが空ではないか確認
        if passwordTextField.text == "" || conformPasswordTextFeild.text == "" {
            return false
        }
        
        // パスワードが異なっていないか確認
        if passwordTextField.text != conformPasswordTextFeild.text {
            delegate?.showAlert(title: "メッセージ", message: "パスワードが一致していません")
            return false
        }
        
        return true
        
    }
    
    func enteredEmail() -> Bool {
        
        // emailがnilではないか確認
        if emailTextFeild.text == nil {
            return false
        }
        
        // emailが空ではないか確認
        if emailTextFeild.text == "" {
            return false
        }
        
        return true
        
    }
    
}
