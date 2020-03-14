//
//  StoreDetailViewController.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/03/04.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

protocol StoreDetailViewControllerDelegate {
    
    func deleteMarker(withIdentifier count: Int)
    
}

class StoreDetailViewController: UIViewController {
    
    //MARK: - Properties
    var storeDetailView: StoreDetailView!
    var storeName: String!
    var storeReview: String!
    var storeImage: String!
    var count: Int!
    var userId: String!
    var latitude: Double!
    var longitude: Double!
    var mapURLString: String!
    var translucentView: UIView!
    var activityIndicatorView: UIActivityIndicatorView!
    var delegate: StoreDetailViewControllerDelegate?
    let restaurantManeger = RestaurantManegerInFirebsae()
    
    init(storeName: String, storeReview: String, storeImage: String, count: Int, userId: String, latitude: Double, longitude: Double) {
        super.init(nibName: nil, bundle: nil)
        self.storeName = storeName
        self.storeReview = storeReview
        self.storeImage = storeImage
        self.userId = userId
        self.count = count
        self.latitude = latitude
        self.longitude = longitude
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if restaurantManeger.CurrentUserAndPostUserIsEquel(withUserID: userId) {
            storeDetailView.deleteStoreButton.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        customizeNav()
        configureSubView()
        configureIndicatorView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        storeDetailView.frame = CGRect(x: view.bounds.origin.x, y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        
    }
    
    func configureSubView() {
        storeDetailView = StoreDetailView()
        storeDetailView.backgroundColor = UIColor(red: 162/255, green: 99/255, blue: 24/255, alpha: 1)
        let storeImageURL = URL(string: storeImage)
        if let unwrapedPostUserIcon = MapViewController.postUserIcon {
            let userIconURL = URL(string: unwrapedPostUserIcon)
            if let unwrapedUserIconURL = userIconURL {
                do {
                    let storeImageData = try Data(contentsOf: storeImageURL!)
                    let userIconData = try Data(contentsOf: unwrapedUserIconURL)
                    self.storeDetailView.storeImageView.image = UIImage(data: storeImageData)
                    self.storeDetailView.postUserIcon.image = UIImage(data: userIconData)
                    print("did set user image from database..")
                } catch _ {
                    print("error..")
                }
            }
            
        } else {
            
            do {
                let storeImageData = try Data(contentsOf: storeImageURL!)
                self.storeDetailView.storeImageView.image = UIImage(data: storeImageData)
                self.storeDetailView.postUserIcon.image = UIImage(named: "profile_icon")
                print("did set user image from database..")
            } catch _ {
                print("error..")
            }
            
        }
        
        storeDetailView.storeNameLabel.text = self.storeName
        storeDetailView.storeImpresstionLabel.text = self.storeReview
        storeDetailView.postUserName.text = MapViewController.postUserName
        
        storeDetailView.deleteStoreButton.addTarget(self, action: #selector(deleteRestaurant), for: .touchUpInside)
        
        view.addSubview(storeDetailView)
    }
    
    func customizeNav() {
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "詳細画面"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: self, action: #selector(back))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ナビ開始", style: .plain, target: self, action: #selector(startNav))
        
    }
    
    func configureIndicatorView() {
        
        translucentView = UIView()
        translucentView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        translucentView.frame.size = CGSize(width: 150, height: 150)
        translucentView.layer.cornerRadius = 20
        translucentView.center = view.center
        translucentView.isHidden = true
        
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.center = translucentView.center
        activityIndicatorView.style = .large
        activityIndicatorView.color = UIColor(red: 44/255, green: 169/255, blue: 225/255, alpha: 1)
        view.addSubview(translucentView)
        view.addSubview(activityIndicatorView)
        
    }
    
    //MARK: - Selectors
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func deleteRestaurant() {
        let alertController = UIAlertController(title: "警告", message: "本当に登録したお店を削除しますか？", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] (_) in
            guard let self = self else { return }
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.storeDetailView.deleteStoreButton.isEnabled = false
            self.translucentView.isHidden = false
            self.activityIndicatorView.startAnimating()
            self.restaurantManeger.deleteRestaurant(withStoreName: self.storeName, ifErrorMessage: { (errorMessage) in
                self.navigationItem.leftBarButtonItem?.isEnabled = true
                self.navigationItem.leftBarButtonItem?.isEnabled = true
                self.storeDetailView.deleteStoreButton.isEnabled = true
                self.translucentView.isHidden = true
                self.activityIndicatorView.stopAnimating()
                UIViewController.noticeAlert(viewController: self, alertTitle: "エラーメッセージ", alertMessage: errorMessage)
            }, completion: {
                self.translucentView.isHidden = true
                self.activityIndicatorView.stopAnimating()
                self.delegate?.deleteMarker(withIdentifier: self.count)
                let alertController = UIAlertController(title: "メッセージ", message: "削除しました", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: { (_) in
                    self.dismiss(animated: true) {
                        self.navigationItem.leftBarButtonItem?.isEnabled = true
                        self.navigationItem.leftBarButtonItem?.isEnabled = true
                        self.storeDetailView.deleteStoreButton.isEnabled = true
                    }
                }))
                self.present(alertController, animated: true, completion: nil)
            })
        }))
        
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func startNav() {
        
        let alertController = UIAlertController(title: nil, message: "ナビを開始します", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Google Map アプリ", style: .default, handler: { (_) in
            print("google map start")
            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
                self.mapURLString = "comgooglemaps://?daddr=\(self.latitude!),\(self.longitude!)&directionsmode=walking&zoom=14"
            } else {
                let alertController = UIAlertController(title: "エラー", message: "アプリがインストールされていません", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            if let url = URL(string: self.mapURLString) {
            UIApplication.shared.open(url)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "標準マップアプリ", style: .default, handler: { (_) in
            print("apple map start")
            if UIApplication.shared.canOpenURL(URL(string:"http://maps.apple.com")!) {
                self.mapURLString = "http://maps.apple.com/?daddr=\(self.latitude!),\(self.longitude!)&dirflg=w"
            } else {
                let alertController = UIAlertController(title: "エラー", message: "アプリがインストールされていません", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            if let url = URL(string: self.mapURLString) {
            UIApplication.shared.open(url)
            }
        }))
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}
