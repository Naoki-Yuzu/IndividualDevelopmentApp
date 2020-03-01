//
//  SideMenuTableView.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

class SideMenuTableView: UITableView {
    
    // MARK: - Init
    init(backgroundColor: UIColor, rowHeight: CGFloat) {
        super.init(frame: CGRect(), style: .plain)
        super.backgroundColor = backgroundColor
        super.rowHeight = rowHeight
        super.separatorStyle = .none
        super.register(SideMenuOptionCell.self, forCellReuseIdentifier: reuseIdentifiler)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
