//
//  OriginalTextField.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

// テキストフィールドを使い回すためのクラス
class OriginalTextField: UITextField {
    
    // MARK: - Inits
    /* キーボードタイプを指定しない場合 */
    init(placeholderText: String, textColor: UIColor) {
        super.init(frame: CGRect())
        super.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        super.textColor = textColor
    }
    
    /* キーボードタイプを指定する場合 */
    init(placeholderText: String, textColor: UIColor, keybordType: UIKeyboardType) {
        super.init(frame: CGRect())
        super.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        super.textColor = textColor
        super.keyboardType = keybordType
    }
    
    /* 親クラスに定義されている必須イニシャライザ */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//extension UITextField {
//
//    func setUnderLineToTF(height: CGFloat, color: UIColor) {
//        self.borderStyle = .none
//        self.layer.backgroundColor = UIColor.purple.cgColor
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = color.cgColor
//        self.layer.shadowOffset = CGSize(width: 0.0, height: heigth)
//        self.layer.shadowOpacity = 1
//        self.layer.shadowRadius = 0.0
        
//        let border = CALayer()
//        border.frame = CGRect(x: 0, y: self.frame.size.height - height, width: self.frame.size.width, height: height)
//        border.backgroundColor = color.cgColor
//        self.layer.addSublayer(border)
//    }
    
//    func addUnderLineToTF(height: CGFloat, color: UIColor) {
//
//        self.borderStyle = .none
//        let underLine = UIView()
//        underLine.backgroundColor = color
//        underLine.frame = CGRect(x: 100, y: self.frame.size.height, width: self.frame.size.width, height: height)
//
//
//        self.addSubview(underLine)
//        self.bringSubviewToFront(underLine)
//
//
//    }
//}
//    var textB: String {
//        didSet {
//            super.attributedPlaceholder =  NSAttributedString(string: "a", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
//        }
//    }
    
//    override var attributedPlaceholder: NSAttributedString {
//        didSet {
//            NSAttributedString(string: textA, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
//        }
//
//    }
//    var textA: String {
//        get  {
//            return "a"
//        }
//        set {
//            super.attributedPlaceholder = NSAttributedString(string: newValue, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
//        }
//
//    }
enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

extension UIView {
    
    func addLine(position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)

        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

        switch position {
        case .LINE_POSITION_TOP:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}
