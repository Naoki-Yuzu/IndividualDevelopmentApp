//
//  AppDelegate.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GMSServices.provideAPIKey(googleMapSDK)
        
        if #available(iOS 13, *) {
                } else {
            
            window = UIWindow(frame: UIScreen.main.bounds)
            let navContainerController = UINavigationController(rootViewController: ContainerController())
            window?.rootViewController = navContainerController
            window?.makeKeyAndVisible()
                    
//                    if Auth.auth().currentUser != nil {
//                        print("exists user..")
//                        if Auth.auth().currentUser!.isEmailVerified {
//
//                            print("is email verified")
//                            window = UIWindow(frame: UIScreen.main.bounds)
//                            let navContainerController = UINavigationController(rootViewController: ContainerController())
//                            window?.rootViewController = navContainerController
//                            window?.makeKeyAndVisible()
//
//                        } else {
//
//                            print("is not email verified")
//                            do {
//
//                                try Auth.auth().signOut()
//                                print("compulsion sign out..")
//
//                                window = UIWindow(frame: UIScreen.main.bounds)
//                                let navContainerController = UINavigationController(rootViewController: SignUpController())
//                                window?.rootViewController = navContainerController
//                                window?.makeKeyAndVisible()
//
//
//                            } catch let error {
//
//                                print(error.localizedDescription)
//
//                            }
//
//                        }
//
//
//
//                    } else {
//
//                        print("no user..")
//                        window = UIWindow(frame: UIScreen.main.bounds)
//                        let signUpNavigationController = UINavigationController(rootViewController: SignUpController())
//                        window?.rootViewController = signUpNavigationController
//                        window?.makeKeyAndVisible()
//
//                    }
                    
                    
                }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

