//
//  SideMenuOption.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import Firebase

enum SideMenuOption: Int, CustomStringConvertible  {
    
    case Profile
    case Signout
    case Register
    
    var description: String {
        switch self {
        case .Profile: return "プロフィール"
        case .Signout: return "ログアウト"
        case .Register: return "お店を登録する"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Profile: return UIImage(named: "profile_icon")?.withTintColor(.white) ?? UIImage()
        case .Signout: return UIImage(named: "sign_out_icon")?.withTintColor(.white) ?? UIImage()
        case .Register: return UIImage(named: "store_icon")?.withTintColor(.white) ?? UIImage()
        }
    }
}
