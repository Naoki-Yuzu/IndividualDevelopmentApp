//
//  ConfirmEmailView.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol ConfirmEmailViewDelegate {
    
    func resendEmail()
    
    func completedRegistration()
    
}

class ConfirmEmailView: UIView {

    // MARK: - Properties
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var resendEmailButton: UIButton!
    var completedRegistrationButton: UIButton!
    
    var delegate: ConfirmEmailViewDelegate?
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        
        self.backgroundColor = .white
        titleLabel = OriginalLabel(textOfLabel: "ご本人様確認", textColor: .black, fontAndSize: .boldSystemFont(ofSize: 20))
        titleLabel.textAlignment = .center
        
        descriptionLabel = OriginalLabel(textOfLabel: "ご本人様確認用のメールを送信いたしました。メールに記載されているリンクをタップし、本人確認を完了させてください。\nこのアプリケーションをバックグラウンドで開いたままメールをご確認ください", textColor: .black, fontAndSize: .boldSystemFont(ofSize: 11))
        descriptionLabel.numberOfLines = 0
        
        
        resendEmailButton = OriginalButton(title: "再送信", titleColor: .white ,fontAndSize: .boldSystemFont(ofSize: 15), backgroundColor: UIColor(red: 65/255, green: 105/255, blue: 225/255, alpha: 1))
        resendEmailButton.addTarget(self, action: #selector(resendEmail), for: .touchUpInside)
        
        completedRegistrationButton = OriginalButton(title: "完了", titleColor: .white, fontAndSize: .boldSystemFont(ofSize: 15), backgroundColor: UIColor(red: 0/255, green: 128/255, blue: 128/255, alpha: 1))
        completedRegistrationButton.addTarget(self, action: #selector(completedRegistration), for: .touchUpInside)
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(resendEmailButton)
        addSubview(completedRegistrationButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Function
    override func updateConstraints() {
        super.updateConstraints()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        resendEmailButton.translatesAutoresizingMaskIntoConstraints = false
        completedRegistrationButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        descriptionLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        
        resendEmailButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30).isActive = true
        resendEmailButton.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -50).isActive = true
        resendEmailButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        resendEmailButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        
        completedRegistrationButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30).isActive = true
        completedRegistrationButton.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 50).isActive = true
        completedRegistrationButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        completedRegistrationButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        
    }
    
    // MARK: - Selectors
    @objc func resendEmail() {
        
        print("taped resend email button")
        delegate?.resendEmail()
        
    }
    
    @objc func completedRegistration() {
        
        print("taped completed retistration button")
        delegate?.completedRegistration()
        
    }
    
}
