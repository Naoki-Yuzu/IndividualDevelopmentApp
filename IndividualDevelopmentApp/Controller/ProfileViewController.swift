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
    var profileView: ProfileView!
    var imageViewTapGesture: UITapGestureRecognizer!
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
        view.addSubview(profileView)
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
        
        print("did tap..")
        if profileView.userNameTextFeild.text == "" {
            
            print("No")
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
                self.userProfile.registerUserInfo(withUserName: self.profileView.userNameTextFeild.text!, userImage: url)
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
    }
    
    @objc func openPhotoLibrary() {
        
        print("image view was tapped..")
        configureImagePicker() // 64行目
        
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
