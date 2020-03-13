//
//  RegisterRestaurantView.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/03/01.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

class RegisterRestaurantView: UIView {
    
    // MARK: - Properties
    var backGroundImage: UIImageView!
    var storeNameLabel: OriginalLabel!
    var storeNameTextField: OriginalTextField!
    var storeImageLabel: OriginalLabel!
    var storeImage: OriginalImageView!
    var storeImpressionLabel: OriginalLabel!
    var impressionTextView: UITextView!
    var textFeildCountLabel: UILabel!
    var textViewCountLabel: UILabel!
    
    // MARK: - Init
    init() {
        super.init(frame: CGRect())
        
        configureSubView() // 75行目
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    override func updateConstraints() {
        super.updateConstraints()
        
        backGroundImage.translatesAutoresizingMaskIntoConstraints = false
        storeImageLabel.translatesAutoresizingMaskIntoConstraints = false
        storeImage.translatesAutoresizingMaskIntoConstraints = false
        storeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        storeNameTextField.translatesAutoresizingMaskIntoConstraints = false
        storeImpressionLabel.translatesAutoresizingMaskIntoConstraints = false
        impressionTextView.translatesAutoresizingMaskIntoConstraints = false
        textFeildCountLabel.translatesAutoresizingMaskIntoConstraints = false
        textViewCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backGroundImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backGroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backGroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backGroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        storeImageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        storeImageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        storeImageLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        storeImageLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true

        storeImage.topAnchor.constraint(equalTo: storeImageLabel.bottomAnchor, constant: 7).isActive = true
        storeImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        storeImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        storeImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        storeNameLabel.topAnchor.constraint(equalTo: storeImage.bottomAnchor, constant: 20).isActive = true
        storeNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        storeNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        storeNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        
        storeNameTextField.topAnchor.constraint(equalTo: storeNameLabel.bottomAnchor, constant: 7).isActive = true
        storeNameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        storeNameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        storeNameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        
        textFeildCountLabel.trailingAnchor.constraint(equalTo: storeNameTextField.trailingAnchor).isActive = true
        textFeildCountLabel.topAnchor.constraint(equalTo: storeNameTextField.bottomAnchor, constant: 5).isActive = true
        textFeildCountLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        textFeildCountLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        storeImpressionLabel.topAnchor.constraint(equalTo: textFeildCountLabel.bottomAnchor, constant: 20).isActive = true
        storeImpressionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        storeImpressionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        storeImpressionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        
        impressionTextView.topAnchor.constraint(equalTo: storeImpressionLabel.bottomAnchor, constant: 7).isActive = true
        impressionTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        impressionTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        impressionTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        
        textViewCountLabel.trailingAnchor.constraint(equalTo: impressionTextView.trailingAnchor).isActive = true
        textViewCountLabel.topAnchor.constraint(equalTo: impressionTextView.bottomAnchor, constant: 5).isActive = true
        textViewCountLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        textViewCountLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
    func configureSubView() {
        
        backGroundImage = UIImageView(image: UIImage(named: "background"))
        backGroundImage.contentMode = .scaleToFill
        backGroundImage.clipsToBounds = true
        storeNameLabel = OriginalLabel(textOfLabel: "店舗名", textColor: .black, fontAndSize: .boldSystemFont(ofSize: 15))
        storeNameTextField = OriginalTextField(placeholderText: "〇〇店", pleceholderTextColor: .black ,textColor: .black)
        storeImageLabel = OriginalLabel(textOfLabel: "写真", textColor: .black, fontAndSize: .boldSystemFont(ofSize: 15))
        storeImage = OriginalImageView(withImage: UIImage(named: "no_image_icon")!, cornerRadius: 20)
        storeNameTextField.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 1)
        storeNameTextField.delegate = self
        storeImpressionLabel = OriginalLabel(textOfLabel: "感想", textColor: .black, fontAndSize: .boldSystemFont(ofSize: 15))
        impressionTextView = UITextView()
        impressionTextView.layer.cornerRadius = 5
        
        textFeildCountLabel = OriginalLabel(textOfLabel: "残り20文字", textColor: .black, fontAndSize: .systemFont(ofSize: 10))
        textViewCountLabel = OriginalLabel(textOfLabel: "残り100文字", textColor: .black, fontAndSize: .systemFont(ofSize: 10))

        addSubview(backGroundImage)
        addSubview(storeImageLabel)
        addSubview(storeImage)
        addSubview(storeNameLabel)
        addSubview(storeNameTextField)
        addSubview(storeImpressionLabel)
        addSubview(impressionTextView)
        addSubview(textViewCountLabel)
        addSubview(textFeildCountLabel)
        
    }
}

extension RegisterRestaurantView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.endEditing(true)
    }
    
}

// MARK: - Delegate
extension RegisterRestaurantView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
