//
//  OriginalImageView.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

class OriginalImageView: UIImageView {
    
    init(withImage image: UIImage, cornerRadius: CGFloat) {
        super.init(frame: CGRect())
        super.image = image
        super.layer.cornerRadius = cornerRadius
        super.contentMode = .scaleAspectFit
        super.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
