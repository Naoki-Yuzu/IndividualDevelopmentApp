//
//  ContainerController.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {
    
    // MARK: - Properties
    var navMapViewController: UIViewController!
    var sideMenuController: UIViewController!
    var mapViewController: MapViewController!
    var isExpansion = false
    let signOutUser = SignOutUser()
    let authenticationUser = SignUpUser()
    
    // MARK: - Helper Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        navigationController?.isNavigationBarHidden = true
        configureMapViewController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        navMapViewController.view.frame = CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.bounds.width, height: view.bounds.height)
    }
    
    func configureMapViewController() {
        
        print("configure map view controller..")
        mapViewController = MapViewController()
//        mapViewController.mapView.reloadMapButton.addTarget(self, action: #selector(reloadMapData), for: .touchUpInside)
        mapViewController.delegate = self
        navMapViewController = UINavigationController(rootViewController: mapViewController)
        
        view.addSubview(navMapViewController.view)
        addChild(navMapViewController)
        navMapViewController.didMove(toParent: self)
        
    }
    
    func configureSideMenuController() {
        if sideMenuController == nil {
            print("configure side menu controller..")
            let localSideMenuController = SideMenuController()
            localSideMenuController.delegate = self
            sideMenuController = localSideMenuController
            view.insertSubview(sideMenuController.view, at: 0)
            addChild(sideMenuController)
            sideMenuController.didMove(toParent: self)
        }
    }
    
    func showSideMenu(shouldExpand: Bool) {
        if shouldExpand {
            print("show menu..")
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                self.navMapViewController.view.frame.origin.x = self.navMapViewController.view.frame.width * 0.6
            }, completion: { (_) in
                self.mapViewController.mapView.reloadMapButton.isEnabled = true
            })
        } else {
            print("hide menu..")
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                self.navMapViewController.view.frame.origin.x = 0
            }, completion: {(_) in
                self.mapViewController.mapView.reloadMapButton.isEnabled = true
            })
        }
    }
    
    func hideSideMenu(sideMenuOption: SideMenuOption) {
        
        print("hide menu..")
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.navMapViewController.view.frame.origin.x = 0
        }) { (_) in
            // 引数は使用しないのため_でok
            self.didSelectSideMenuOption(sideMenuOption: sideMenuOption)
        }
        
    }
    
    func didSelectSideMenuOption(sideMenuOption: SideMenuOption) {
        switch sideMenuOption {
        case .Profile:
            if authenticationUser.authenticationUser() {
                
                mapViewController.mapView.reloadMapButton.isEnabled = true
                mapViewController.mapView.isUserInteractionEnabled = true
                mapViewController.view.isUserInteractionEnabled = true
                
                switch authenticationUser.confirmEmailVerified() {
                case true:
                    let navProfileViewController = UINavigationController(rootViewController: ProfileViewController())
                    navProfileViewController.modalPresentationStyle = .fullScreen
                    present(navProfileViewController, animated: true, completion: nil)
                    break
                case false :
                    let navConfirmEmailLogInController = UINavigationController(rootViewController: ConfirmEmailControllerInLogIn())
                    navConfirmEmailLogInController.modalPresentationStyle = .fullScreen
                    present(navConfirmEmailLogInController, animated: true, completion: nil)
                    break
                }
                
                
                
                
            } else {
                
                mapViewController.mapView.reloadMapButton.isEnabled = true
                mapViewController.mapView.isUserInteractionEnabled = true
                mapViewController.view.isUserInteractionEnabled = true
                UIViewController.displayAlertOfAlertStyle(viewController: self, title: "メッセージ", message: "新規アカウントの作成、またはログインが必要です。", rightActionCompletion: {
                    
                    let navSignUpController = UINavigationController(rootViewController: SignUpController())
                    navSignUpController.modalPresentationStyle = .fullScreen
                    self.present(navSignUpController, animated: true, completion: nil)
                    
                }, leftActionCompletion: nil)
                
            }
            
        case .Register:
            if authenticationUser.authenticationUser() {
                
                mapViewController.mapView.reloadMapButton.isEnabled = true
                mapViewController.mapView.isUserInteractionEnabled = true
                mapViewController.view.isUserInteractionEnabled = true
                
                switch authenticationUser.confirmEmailVerified() {
                case true:
                    print("本人登録確認済みよ")
                    let registerRestaurantViewController = RegisterRestaurantViewController()
                    registerRestaurantViewController.delegete = mapViewController!
                    let navRegisterRestaurantViewController = UINavigationController(rootViewController: registerRestaurantViewController)
                    navRegisterRestaurantViewController.modalPresentationStyle = .fullScreen
                    present(navRegisterRestaurantViewController, animated: true, completion: nil)
                    break
                case false :
                    let navConfirmEmailLogInController = UINavigationController(rootViewController: ConfirmEmailControllerInLogIn())
                    navConfirmEmailLogInController.modalPresentationStyle = .fullScreen
                    present(navConfirmEmailLogInController, animated: true, completion: nil)
                    break
                }
                
            } else {
                
                mapViewController.mapView.reloadMapButton.isEnabled = true
                mapViewController.mapView.isUserInteractionEnabled = true
                mapViewController.view.isUserInteractionEnabled = true
                UIViewController.displayAlertOfAlertStyle(viewController: self, title: "メッセージ", message: "新規アカウントの作成、またはログインが必要です。", rightActionCompletion: {
                    
                    let navSignUpController = UINavigationController(rootViewController: SignUpController())
                    navSignUpController.modalPresentationStyle = .fullScreen
                    self.present(navSignUpController, animated: true, completion: nil)
                    
                }, leftActionCompletion: nil)
                
            }
        case .Signout:
            
            if authenticationUser.authenticationUser() {
                
                mapViewController.mapView.reloadMapButton.isEnabled = true
                mapViewController.mapView.isUserInteractionEnabled = true
                mapViewController.view.isUserInteractionEnabled = true
                SignOutAlert()
                
            } else {
                
                mapViewController.mapView.reloadMapButton.isEnabled = true
                mapViewController.mapView.isUserInteractionEnabled = true
                mapViewController.view.isUserInteractionEnabled = true
                UIViewController.displayAlertOfAlertStyle(viewController: self, title: "メッセージ", message: "新規アカウントの作成、またはログインが必要です。", rightActionCompletion: {
                    
                    let navSignUpController = UINavigationController(rootViewController: SignUpController())
                    navSignUpController.modalPresentationStyle = .fullScreen
                    self.present(navSignUpController, animated: true, completion: nil)
                    
                }, leftActionCompletion: nil)
                
            }

//            mapViewController.mapView.reloadMapButton.isEnabled = true
//            mapViewController.mapView.isUserInteractionEnabled = true
//            mapViewController.view.isUserInteractionEnabled = true
//            SignOutAlert()
        case .Delete:
            if authenticationUser.authenticationUser() {
                
                mapViewController.mapView.reloadMapButton.isEnabled = true
                mapViewController.mapView.isUserInteractionEnabled = true
                mapViewController.view.isUserInteractionEnabled = true
                deleteAccountAlert()
                
            } else {
                
                mapViewController.mapView.reloadMapButton.isEnabled = true
                mapViewController.mapView.isUserInteractionEnabled = true
                mapViewController.view.isUserInteractionEnabled = true
                UIViewController.displayAlertOfAlertStyle(viewController: self, title: "メッセージ", message: "新規アカウントの作成、またはログインが必要です。", rightActionCompletion: {
                    
                    let navSignUpController = UINavigationController(rootViewController: SignUpController())
                    navSignUpController.modalPresentationStyle = .fullScreen
                    self.present(navSignUpController, animated: true, completion: nil)
                    
                }, leftActionCompletion: nil)
                
            }
//            mapViewController.mapView.reloadMapButton.isEnabled = true
//            mapViewController.mapView.isUserInteractionEnabled = true
//            mapViewController.view.isUserInteractionEnabled = true
//            deleteAccountAlert()
        }
        
    }
    
    func SignOutAlert() {
        
        let alertController = UIAlertController(title: "メッセージ", message: "本当にログアウトしてもよろしいですか？", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {(_) in
            self.signOutUser.signOutUser {
//                self.navigationController?.pushViewController(SignUpController(), animated: true)
                UIViewController.displayAlertOfAlertStyle(viewController: self, title: "メッセージ", message: "ログアウトしました", rightActionCompletion: {
                        self.mapViewController.mapView.isUserInteractionEnabled = true
                        self.mapViewController.mapView.sideMenuButton.isEnabled = true
                        self.mapViewController.mapView.reloadMapButton.isEnabled = true
                }, leftActionTitle: nil ,leftActionCompletion: nil)
            }
        }))
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)

        
    }
    
    func deleteAccountAlert() {
        
        let alertController = UIAlertController(title: "警告", message: "本当にアカウントを削除してもよろしいですか？\nまた今まで投稿した内容は、自動的には削除されません。", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {(_) in
            
            self.mapViewController.activityIndicatorView.startAnimating()
            self.mapViewController.translucentView.isHidden = false
            self.mapViewController.mapView.isUserInteractionEnabled = false
            self.mapViewController.mapView.sideMenuButton.isEnabled = false
            self.mapViewController.mapView.reloadMapButton.isEnabled = false
            
            let deleteUser = DeleteUserAccount()
            deleteUser.deleteUser(errorMessage: {(errorMessage) in
                UIViewController.noticeAlert(viewController: self, alertTitle: "サーバーエラー", alertMessage: errorMessage)
                self.mapViewController.activityIndicatorView.stopAnimating()
                self.mapViewController.translucentView.isHidden = true
                self.mapViewController.mapView.isUserInteractionEnabled = true
                self.mapViewController.mapView.sideMenuButton.isEnabled = true
                self.mapViewController.mapView.reloadMapButton.isEnabled = true
                
            }) {
                
                self.mapViewController.activityIndicatorView.stopAnimating()
                self.mapViewController.translucentView.isHidden = true
                
                let alertController = UIAlertController(title: "メッセージ", message: "アカウントを削除しました", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    UIViewController.displayAlertOfAlertStyle(viewController: self, title: "メッセージ", message: "アカウントの削除が完了しました", rightActionCompletion: {
                            self.mapViewController.mapView.isUserInteractionEnabled = true
                            self.mapViewController.mapView.sideMenuButton.isEnabled = true
                            self.mapViewController.mapView.reloadMapButton.isEnabled = true
                        }, leftActionTitle: nil ,leftActionCompletion: nil)
                }))
                
                self.present(alertController, animated: true, completion: nil)
                
            }
        }))
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK: - Selctors
    @objc func reloadMapData() {
        
        print("tapped reload map data..")
        
    }

    
}

// MARK: - Delegate
extension ContainerController: MapViewControllerDelegate {
    
    func hideMenu() {
        mapViewController.mapView.isUserInteractionEnabled = true
        mapViewController.view.isUserInteractionEnabled = true
        isExpansion = !isExpansion
        showSideMenu(shouldExpand: isExpansion)
    }
    
    func showOrHideSideMenu() {
        print("came container controller..")
        if !isExpansion {
            configureSideMenuController()
        }
        
        isExpansion = !isExpansion
        showSideMenu(shouldExpand: isExpansion)
        
    }
    
}

extension ContainerController: SideMenuControllerDelegate {
    
    func hideSideMenu(forSideMenuOption sideMenuOption: SideMenuOption) {
        hideSideMenu(sideMenuOption: sideMenuOption)
        isExpansion = false
    }
    
    
    
}
