//
//  OriginalLabel.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

// ラベルを使い回すためのクラス
class OriginalLabel: UILabel {
    
    // MARK: - Inits
    init(textOfLabel: String, textColor: UIColor, fontAndSize: UIFont ) {
        super.init(frame: CGRect())
        super.text = textOfLabel
        super.textColor = textColor
        super.font = fontAndSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
