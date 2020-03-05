//
//  StoreDetailView.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/03/04.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

class StoreDetailView: UIView {
    
    //MARK: - Properties
    var splitView: UIView!
    var splitView2: UIView!
    var postUserView: UIView!
    var scrollView: UIScrollView!
    var line: OriginalLine!
    var line2: OriginalLine!
    var line3: OriginalLine!
    var line4: OriginalLine!
    var storeNameLabel: OriginalLabel!
    var storeImageView: OriginalImageView!
    var storeImpresstionTitleLabel: OriginalLabel!
    var storeImpresstionLabel: OriginalLabel!
    
    //MARK: - Init
    init() {
        super.init(frame: CGRect())
        
        configureSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Fuctions
    override func layoutSubviews() {
        super.layoutSubviews()
        
        splitView.frame.size = CGSize(width: self.bounds.width * 0.9, height: self.bounds.height * 0.95)
        splitView.center = self.center
        
        scrollView.frame = CGRect(x: splitView.bounds.origin.x, y: splitView.bounds.origin.y, width: splitView.bounds.width, height: splitView.bounds.height)
        
        storeNameLabel.frame = CGRect(x: scrollView.bounds.width / 4, y: scrollView.bounds.origin.y + 10, width: scrollView.bounds.width / 2, height: 50)
        
        line.frame = CGRect(x: scrollView.bounds.width * 0.05, y: storeNameLabel.bounds.height + 20, width: scrollView.bounds.width * 0.9, height: 0.7)
        
        storeImageView.frame = CGRect(x: scrollView.bounds.width / 4, y: storeNameLabel.bounds.height + line.bounds.height + 40, width: scrollView.bounds.width / 2, height: 150)
        
        line2.frame = CGRect(x: scrollView.bounds.width * 0.05, y: storeNameLabel.bounds.height + line.bounds.height + storeImageView.bounds.height + 60, width: scrollView.bounds.width * 0.9, height: 0.7)
        
        postUserView.frame = CGRect(x: scrollView.bounds.width * 0.1, y: storeNameLabel.bounds.height + line.bounds.height + storeImageView.bounds.height + line2.bounds.height + 80, width: scrollView.bounds.width * 0.8, height: 100)
        
        line4.frame = CGRect(x: scrollView.bounds.width * 0.05, y: storeNameLabel.bounds.height + line.bounds.height + storeImageView.bounds.height + postUserView.bounds.height + 100, width: scrollView.bounds.width * 0.9, height: 0.7)
        
//        splitView2.frame = CGRect(x: scrollView.bounds.width * 0.1, y: storeNameLabel.bounds.height + line.bounds.height + storeImageView.bounds.height + line2.bounds.height + postUserView.bounds.height + line4.bounds.height + 120 , width: scrollView.bounds.width * 0.8, height: 400)
        let splitViewOriginY = storeNameLabel.bounds.height + line.bounds.height + storeImageView.bounds.height + line2.bounds.height + postUserView.bounds.height + line4.bounds.height
        
        splitView2.frame = CGRect(x: scrollView.bounds.width * 0.1, y: splitViewOriginY + 120, width: scrollView.bounds.width * 0.8, height: 400)
        
        storeImpresstionTitleLabel.frame = CGRect(x: splitView2.bounds.width * 0.15, y: splitView2.bounds.origin.y + 20, width: splitView2.bounds.width * 0.7, height: 20)
        
        line3.frame = CGRect(x: splitView2.bounds.origin.x, y: storeImpresstionTitleLabel.bounds.height + 40, width: splitView2.bounds.width,  height: 1)
        
        storeImpresstionLabel.frame = CGRect(x: splitView2.bounds.width * 0.15, y: storeImpresstionTitleLabel.bounds.height + line3.bounds.height + 60, width: splitView2.bounds.width * 0.7, height: 299)
        
        var rect = storeImpresstionLabel.frame
        storeImpresstionLabel.sizeToFit()
        rect.size.height = storeImpresstionLabel.frame.height
        storeImpresstionLabel.frame = rect
        
        
        scrollView.contentSize = CGSize(width: splitView.bounds.width, height: splitViewOriginY + splitView2.bounds.height + 140)
        
    }
    
    func configureSubView() {
        splitView = UIView()
        splitView.backgroundColor = .white
        splitView.layer.cornerRadius = 15
        splitView.layer.shadowOffset = CGSize(width: 0, height: 0)
        splitView.layer.shadowColor = UIColor.gray.cgColor
        splitView.layer.shadowOpacity = 1
        splitView.layer.shadowRadius = 5
        
        scrollView = UIScrollView()
        
        line = OriginalLine(color: .black)
        line2 = OriginalLine(color: .black)
        line4 = OriginalLine(color: .black)
        
        storeNameLabel = OriginalLabel(textOfLabel: "もふふ", textColor: .black, fontAndSize: .boldSystemFont(ofSize: 20))
        storeNameLabel.textAlignment = .center
        storeNameLabel.adjustsFontSizeToFitWidth = true
        storeImageView = OriginalImageView(withImage: UIImage(named: "store_icon")!, cornerRadius: 3)
        storeImageView.contentMode = .scaleAspectFit
        
        postUserView = UIView()
        postUserView.backgroundColor = .red
        
        splitView2 = UIView()
        splitView2.backgroundColor = .white
        splitView2.layer.cornerRadius = 15
        splitView2.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        splitView2.layer.shadowOffset = CGSize(width: 0, height: 0)
        splitView2.layer.shadowColor = UIColor.black.cgColor
        splitView2.layer.shadowOpacity = 1
        splitView2.layer.shadowRadius = 2
        
        line3 = OriginalLine(color: .lightGray)
        line3.layer.shadowOffset = CGSize(width: 0, height: 0)
        line3.layer.shadowColor = UIColor.black.cgColor
        line3.layer.shadowOpacity = 1
        line3.layer.shadowRadius = 2
        
        storeImpresstionTitleLabel = OriginalLabel(textOfLabel: "投稿者のレビュー", textColor: .black, fontAndSize: .boldSystemFont(ofSize: 15))
        storeImpresstionTitleLabel.textAlignment = .center
        
        storeImpresstionLabel = OriginalLabel(textOfLabel: "のふふもふもふもふもふおふおふもふもふfもふもふいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい", textColor: .black, fontAndSize: .systemFont(ofSize: 15))
        storeImpresstionLabel.numberOfLines = 0
        
        // Create a new Attributed String
        let attributedString = NSMutableAttributedString.init(string: storeImpresstionLabel.text!)
        
        // Add Underline Style Attribute.
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
            NSRange.init(location: 0, length: attributedString.length));
        storeImpresstionLabel.attributedText = attributedString

        
        addSubview(splitView)
        splitView.addSubview(scrollView)
        scrollView.addSubview(storeNameLabel)
        scrollView.addSubview(line)
        scrollView.addSubview(storeImageView)
        scrollView.addSubview(line2)
        scrollView.addSubview(postUserView)
        scrollView.addSubview(line4)
        scrollView.addSubview(splitView2)
        splitView2.addSubview(storeImpresstionTitleLabel)
        splitView2.addSubview(line3)
        splitView2.addSubview(storeImpresstionLabel)
        
    }
    
    
    
}
