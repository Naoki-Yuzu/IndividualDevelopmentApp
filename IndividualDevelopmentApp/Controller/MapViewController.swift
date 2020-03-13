//
//  MapViewController.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit
import GoogleMaps

protocol MapViewControllerDelegate {
    func showOrHideSideMenu()
    
    func hideMenu()
}

class MapViewController: UIViewController {
    
    // MARK: - Properties
    static var postUserName: String!
    static var postUserIcon: String!
    var mapView: MapView!
    var delegate: MapViewControllerDelegate?
    var storeModel: GetStoreInfo!
    var storeName: [String] = []
    var storeReview: [String] = []
    var storeImage: [String] = []
    var userIdArray: [String] = []
    var latitudeArray: [Double] = []
    var longitudeArray: [Double] = []
    var count = 0
    var storeCount = 0
    var viewTapGesture: UITapGestureRecognizer!
    var translucentView: UIView!
    var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Helper Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear..")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will desappear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeName.removeAll()
        storeReview.removeAll()
        storeName.removeAll()
        userIdArray.removeAll()
        latitudeArray.removeAll()
        longitudeArray.removeAll()
        view.backgroundColor = .gray
        navigationController?.isNavigationBarHidden = true
        configureMapView()
        configureIndicatorView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        mapView.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: view.frame.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right, height: view.frame.size.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
//        mapView.frame = CGRect(x: view.safeAreaInsets.left, y: view.frame.origin.y, width: view.frame.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right, height: view.frame.size.height)
        mapView.frame = CGRect(x:0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
    
    func configureMapView() {
        let localMapview = MapView()
        localMapview.delegate = self
        localMapview.mapView.delegate = self
        mapView = localMapview
        view.addSubview(mapView)
        view.isUserInteractionEnabled = true
        print("called configureUIView in MapViewController..")
            
        getStoresData()
        
    }
    
    func configureViewTapGesture() {
        
        print("configure view tap gesture")
        mapView.isUserInteractionEnabled = false
        viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(hideSideMenu))
        view.addGestureRecognizer(viewTapGesture)
        
        
    }
    
    func getStoresData() {
        
        print("start get stores data..")
        storeModel = GetStoreInfo()
        storeModel.getStoreInfo { [weak self] (snapShot) in
            if let self = self {
                
                for document in snapShot.documents {

                        let storeData = document.data()
                        guard let latitude = storeData["latitude"] as? Double, let longitude = storeData["longitude"] as? Double, let storeName = storeData["storeName"] as? String, let storeImage = storeData["storeImage"] as? String, let storeReview = storeData["storeImpression"] as? String, let userId = storeData["userId"] as? String else { return }

                        self.configureMakerInMap(latitude: latitude, longitude: longitude, storeName: storeName, count: self.count, storeReview: storeReview, storeImage: storeImage, userId: userId)
                        self.count += 1

                    }
                
            }
            
        }
        
    }
    
    func configureMakerInMap(latitude: Double, longitude: Double, storeName: String, count: Int, storeReview: String, storeImage: String, userId: String) {
        
        print("configure maker..")
        let position = CLLocationCoordinate2DMake(latitude, longitude)
        let marker = GMSMarker(position: position)
        marker.title = storeName
        marker.identifier = count
        marker.map = mapView.mapView
        configureArrays(storeName: storeName, storeReview: storeReview, storeImage: storeImage, count: count, userId: userId, latitude: latitude, longitude: longitude)
        print("ウヘヘ")
        
        
    }
    
    func configureArrays(storeName: String, storeReview: String, storeImage: String, count: Int, userId: String, latitude: Double, longitude: Double) {
        self.storeName.append(storeName)
        self.storeReview.append(storeReview)
        self.storeImage.append(storeImage)
        self.userIdArray.append(userId)
        self.latitudeArray.append(latitude)
        self.longitudeArray.append(longitude)
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
    
    // MARK: Selectors
    @objc func hideSideMenu() {
        delegate?.hideMenu()
    }

}

// Markerに識別子を持たせるための変数
extension GMSMarker {
    var identifier: Int {
        set(identifier) {
            self.userData = identifier
        }

        get {
           return self.userData as! Int
       }
   }
}

// MARK: Delegates
extension MapViewController: MapViewDelegate {
    
    
    func showOrHideSideMenu() {
        print("came map view controller..")
        delegate?.showOrHideSideMenu()
        configureViewTapGesture()

    }
    
}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        translucentView.isHidden = false
        activityIndicatorView.startAnimating()
        self.mapView.isUserInteractionEnabled = false
        let userId = userIdArray[marker.identifier]
        storeModel.getPostUserInfo(userId: userId) { [weak self] (snapShot) in
            if let self = self {
                if snapShot.data() == nil {
                    MapViewController.postUserName = "名無しさん"
                } else {
                    let userInfo = snapShot.data()
                    guard let postUserName = userInfo!["userName"] as? String, let postUserIcon = userInfo!["userImage"] as? String else { return }
                    MapViewController.postUserName = postUserName
                    MapViewController.postUserIcon = postUserIcon
                }
                
                let navStoreDetailViewController = UINavigationController(rootViewController: StoreDetailViewController(storeName: self.storeName[marker.identifier], storeReview: self.storeReview[marker.identifier], storeImage: self.storeImage[marker.identifier], count: self.count, userId: self.userIdArray[marker.identifier], latitude: self.latitudeArray[marker.identifier], longitude: self.longitudeArray[marker.identifier]))
                navStoreDetailViewController.modalPresentationStyle = .fullScreen
                self.present(navStoreDetailViewController, animated: true) {
                    self.translucentView.isHidden = true
                    self.activityIndicatorView.stopAnimating()
                    self.mapView.isUserInteractionEnabled = true
                }
                print("did tap info window of maker..")
            }
        }
        
    }
    
}

extension UIViewController {
    
}
