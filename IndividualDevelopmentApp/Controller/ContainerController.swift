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
            }, completion: nil)
        } else {
            print("hide menu..")
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                self.navMapViewController.view.frame.origin.x = 0
            }, completion: nil)
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
            mapViewController.mapView.isUserInteractionEnabled = true
            mapViewController.view.isUserInteractionEnabled = true
            let navProfileViewController = UINavigationController(rootViewController: ProfileViewController())
            navProfileViewController.modalPresentationStyle = .fullScreen
            present(navProfileViewController, animated: true, completion: nil)
        case .Register:
            mapViewController.mapView.isUserInteractionEnabled = true
            mapViewController.view.isUserInteractionEnabled = true
            let registerRestaurantViewController = RegisterRestaurantViewController()
            let navRegisterRestaurantViewController = UINavigationController(rootViewController: registerRestaurantViewController)
            navRegisterRestaurantViewController.modalPresentationStyle = .fullScreen
            present(navRegisterRestaurantViewController, animated: true, completion: nil)
        case .Signout:
            mapViewController.mapView.isUserInteractionEnabled = true
            mapViewController.view.isUserInteractionEnabled = true
            SignOutAlert()
        case .Delete:
            mapViewController.mapView.isUserInteractionEnabled = true
            mapViewController.view.isUserInteractionEnabled = true
            deleteAccountAlert()
        }
        
    }
    
    func SignOutAlert() {
        
        let alertController = UIAlertController(title: "メッセージ", message: "本当にログアウトしてもよろしいですか？", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {(_) in
            self.signOutUser.signOutUser {
                self.navigationController?.pushViewController(SignUpController(), animated: true)
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
            
            let deleteUser = DeleteUserAccount()
            deleteUser.deleteUser(errorMessage: {(errorMessage) in
                UIViewController.noticeAlert(viewController: self, alertTitle: "サーバーエラー", alertMessage: errorMessage)
                self.mapViewController.activityIndicatorView.stopAnimating()
                self.mapViewController.translucentView.isHidden = true
                self.mapViewController.mapView.isUserInteractionEnabled = true
                self.mapViewController.mapView.sideMenuButton.isEnabled = true
                
            }) {
                
                self.mapViewController.activityIndicatorView.stopAnimating()
                self.mapViewController.translucentView.isHidden = true
                
                let alertController = UIAlertController(title: "メッセージ", message: "アカウントを削除しました", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    self.navigationController?.pushViewController(SignUpController(), animated: true)
                    self.mapViewController.mapView.isUserInteractionEnabled = true
                    self.mapViewController.mapView.sideMenuButton.isEnabled = true
                }))
                
                self.present(alertController, animated: true, completion: nil)
                
            }
        }))
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
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
