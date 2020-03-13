//
//  RegisterRestaurantScrollView.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/03/02.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

class RegisterRestaurantScrollView: UIScrollView {
    
    // MARK: - Properties
        var backGroundImage: UIImageView!
        var storeNameLabel: OriginalLabel!
        var storeNameTextField: OriginalTextField!
        var storeImageLabel: OriginalLabel!
        var storeImage: OriginalImageView!
        var storeImpressionLabel: OriginalLabel!
        var impressionTextView: UITextView!
        
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
            
            storeImageLabel.translatesAutoresizingMaskIntoConstraints = false
            storeImage.translatesAutoresizingMaskIntoConstraints = false
            storeNameLabel.translatesAutoresizingMaskIntoConstraints = false
            storeNameTextField.translatesAutoresizingMaskIntoConstraints = false
            storeImpressionLabel.translatesAutoresizingMaskIntoConstraints = false
            impressionTextView.translatesAutoresizingMaskIntoConstraints = false
            
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
            
            storeImpressionLabel.topAnchor.constraint(equalTo: storeNameTextField.bottomAnchor, constant: 20).isActive = true
            storeImpressionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            storeImpressionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
            storeImpressionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
            
            impressionTextView.topAnchor.constraint(equalTo: storeImpressionLabel.bottomAnchor, constant: 7).isActive = true
            impressionTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            impressionTextView.heightAnchor.constraint(equalToConstant: 70).isActive = true
            impressionTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
            
        }
        
        func configureSubView() {
            
            storeNameLabel = OriginalLabel(textOfLabel: "店舗名", textColor: .black, fontAndSize: .boldSystemFont(ofSize: 15))
            storeNameTextField = OriginalTextField(placeholderText: "〇〇店", pleceholderTextColor: .lightGray ,textColor: .black)
            storeImageLabel = OriginalLabel(textOfLabel: "写真", textColor: .black, fontAndSize: .boldSystemFont(ofSize: 15))
            storeImage = OriginalImageView(withImage: UIImage(named: "no_image_icon")!, cornerRadius: 20)
            storeNameTextField.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 1)
            storeNameTextField.delegate = self
            storeImpressionLabel = OriginalLabel(textOfLabel: "感想", textColor: .black, fontAndSize: .boldSystemFont(ofSize: 15))
            impressionTextView = UITextView()
            impressionTextView.layer.cornerRadius = 5
            
            addSubview(storeImageLabel)
            addSubview(storeImage)
            addSubview(storeNameLabel)
            addSubview(storeNameTextField)
            addSubview(storeImpressionLabel)
            addSubview(impressionTextView)
            
        }
    
}

extension RegisterRestaurantScrollView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.endEditing(true)
    }
    
}

// MARK: - Delegate
extension RegisterRestaurantScrollView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

