//
//  ProfileViewController.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    var translucentView: UIView!
    var activityIndicatorView: UIActivityIndicatorView!
    var profileView: ProfileView!
    var imageViewTapGesture: UITapGestureRecognizer!
    var textFieldCountRemaining: Int!
    let textFieldMaxString = 10
    let userProfile = UserProfile()
    
    
    // MARK: - Init
    override func loadView() {
        super.loadView()
        
        configureNavAndView()
    }
    
    // MARK: - Helper Functions
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profileView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
//        profileView.frame = CGRect(x: view.bounds.origin.x, y: view.safeAreaInsets.top + (navigationController?.navigationBar.bounds.size.height)!, width: view.bounds.width, height: view.bounds.height - (navigationController?.navigationBar.bounds.size.height)!)
    }
    
    func configureNavAndView() {
        
        navigationController?.navigationBar.barTintColor = .lightGray
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "プロフィール"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登録", style: .plain, target: self, action: #selector(registerUserInfo))
        
        view.backgroundColor = .white
        profileView = ProfileView()
        profileView.userNameTextFeild.delegate = self
        view.addSubview(profileView)
        configureIndicatorView()
        configureImageTapGesture() // 50行目
        getUserInfo()
        
    }
    
    func configureImageTapGesture() {
        
        print("configure image tap gesture..")
        imageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(openPhotoLibrary))
        profileView.userImage.isUserInteractionEnabled = true
        profileView.userImage.addGestureRecognizer(imageViewTapGesture)
        
    }
    
    func configureImagePicker() {
        
        print("configure image picker..")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func configureIndicatorView() {
        
        translucentView = UIView()
        translucentView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        translucentView.frame.size = CGSize(width: 150, height: 150)
        translucentView.layer.cornerRadius = 20
        translucentView.center = view.center
        translucentView.isHidden = true
        
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.center = translucentView.center
        activityIndicatorView.style = .large
        activityIndicatorView.color = UIColor(red: 44/255, green: 169/255, blue: 225/255, alpha: 1)
        view.addSubview(translucentView)
        view.addSubview(activityIndicatorView)
        
    }
    
    func getUserInfo() {
        
        print("get user information..")
        userProfile.getUserInfo { (document) in
            guard let userInfo = document.data() else { return }
            self.profileView.userNameTextFeild.text = userInfo["userName"] as? String ?? "名無しさん"
            guard let userImage = userInfo["userImage"] as? String else { return }
            let url = URL(string: userImage)
            do {
                let data = try Data(contentsOf: url!)
                self.profileView.userImage.image = UIImage(data: data)
                print("did set user image from database..")
            } catch _ {
                print("error..")
            }
            
        }
        
    }
    
    // MARK: - Selectors
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    // ユーザーの名前とアイコン画像を変更しFirebaseに保存するメソッド
    @objc func registerUserInfo() {
        
        translucentView.isHidden = false
        activityIndicatorView.startAnimating()
        profileView.userImage.isUserInteractionEnabled = false
        profileView.userNameTextFeild.isEnabled = false
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.leftBarButtonItem?.isEnabled = false
        print("did tap..")
        if profileView.userNameTextFeild.text == "" {
            
            print("No")
            translucentView.isHidden = true
            profileView.userImage.isUserInteractionEnabled = true
            profileView.userNameTextFeild.isEnabled = true
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.leftBarButtonItem?.isEnabled = true
            activityIndicatorView.stopAnimating()
            let alertController = UIAlertController(title: "エラー", message: "ユーザー名が記入されていません", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            
        } else {
            print("Ok")
            userProfile.uploadUserProfileImage(withUIImage: profileView.userImage.image!) {
                // ここから cloud firestore に保存する
                guard let url = self.userProfile.stringOfURL else {
                    print("can't unwrap..")
                    return }
                
                print("did unwrap..")
                self.userProfile.registerUserInfo(withUserName: self.profileView.userNameTextFeild.text!, userImage: url) {
                    self.dismiss(animated: true) {
                        self.translucentView.isHidden = true
                        self.activityIndicatorView.stopAnimating()
                        self.profileView.userNameTextFeild.isEnabled = true
                        self.profileView.userImage.isUserInteractionEnabled = true
                        self.navigationItem.rightBarButtonItem?.isEnabled = true
                        self.navigationItem.leftBarButtonItem?.isEnabled = true
                    }
                }
                
            }
            
        }
        
    }
    
    @objc func openPhotoLibrary() {
        
        print("image view was tapped..")
        configureImagePicker() // 64行目
        
    }
    
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text, let isUndoing = textField.undoManager?.isUndoing,
        let isRedoing = textField.undoManager?.isRedoing else { return }
        
        
        textFieldCountRemaining = textFieldMaxString - text.count
        profileView.textFieldCountLabel.text = "残り\(textFieldCountRemaining!)文字"
        
        if textField.markedTextRange == nil && text.count > textFieldMaxString && !isRedoing && !isUndoing {
            let endIndex = text.index(text.startIndex, offsetBy: textFieldMaxString)
            textField.text = String(text[..<endIndex])
        }
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        print("did select..")
        profileView.userImage.image = pickedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("did cancel..")
        dismiss(animated: true, completion: nil)
    }
    
}
