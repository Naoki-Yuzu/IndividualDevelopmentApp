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
    case Register
    case Signout
    case Delete
    
    var description: String {
        switch self {
        case .Profile: return "プロフィール"
        case .Register: return "お店を登録する"
        case .Signout: return "ログアウト"
        case .Delete: return "アカウント削除"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Profile: return UIImage(named: "profile_icon")?.withTintColor(.white) ?? UIImage()
        case .Signout: return UIImage(named: "sign_out_icon")?.withTintColor(.white) ?? UIImage()
        case .Register: return UIImage(named: "store_icon")?.withTintColor(.white) ?? UIImage()
        case .Delete: return UIImage(named: "delete_account" )?.withTintColor(.white) ?? UIImage()
        }
    }
}
