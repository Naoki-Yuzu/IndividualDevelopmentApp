//
//  ProfileView.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    // MARK: - Properties
    var userImage: UIImageView!
    var userNameTextFeild: UITextField!
    var userNameLabel: UILabel!
    var profileViewController: UIViewController!
    var textFieldCountLabel: UILabel!
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        print("did init profile view")
        
        configureSubView() // 57行目
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Functions
    override func updateConstraints() {
        super.updateConstraints()
        print("update constraints profile view..")
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameTextFeild.translatesAutoresizingMaskIntoConstraints = false
        textFieldCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
        userImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        userNameLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 40).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        userNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        
        userNameTextFeild.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 3).isActive = true
        userNameTextFeild.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        userNameTextFeild.heightAnchor.constraint(equalToConstant: 40).isActive = true
        userNameTextFeild.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        
        textFieldCountLabel.trailingAnchor.constraint(equalTo: userNameTextFeild.trailingAnchor).isActive = true
        textFieldCountLabel.topAnchor.constraint(equalTo: userNameTextFeild.bottomAnchor, constant: 5).isActive = true
        textFieldCountLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        textFieldCountLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
    func configureSubView() {
        
        userImage = OriginalImageView(withImage: UIImage(named: "profile_icon")!, cornerRadius: 50)
        userNameLabel = OriginalLabel(textOfLabel: "ユーザー名", textColor: .black, fontAndSize: .boldSystemFont(ofSize: 16))
        userNameTextFeild = UITextField()
        userNameTextFeild.textColor = .black
        userNameTextFeild.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 1)
        
        textFieldCountLabel = OriginalLabel(textOfLabel: "残り10文字", textColor: .black, fontAndSize: .systemFont(ofSize: 10))
        
        addSubview(userNameLabel)
        addSubview(userImage)
        addSubview(userNameTextFeild)
        addSubview(textFieldCountLabel)
        
    }
    
}

extension ProfileView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
}
