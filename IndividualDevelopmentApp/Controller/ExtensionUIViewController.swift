//
//  ExtensionUIViewController.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/03/08.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

//class AlertController {
//    
//    class func noticeAlert(viewController: UIViewController, alertTitle: String ,alertMessage: String) {
//        
//        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
//        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        
//        alertController.addAction(defaultAction)
//        viewController.present(alertController, animated: true, completion: nil)
//
//    }
//}

extension UIViewController {
    
    class func noticeAlert(viewController: UIViewController, alertTitle: String ,alertMessage: String) {
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(defaultAction)
        viewController.present(alertController, animated: true, completion: nil)

    }
    
}
