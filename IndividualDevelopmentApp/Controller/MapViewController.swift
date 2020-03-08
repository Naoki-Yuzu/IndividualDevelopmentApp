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
    var mapView: MapView!
    var delegate: MapViewControllerDelegate?
    var storeModel: GetStoreInfo!
    var storeDetailViewControllers: [StoreDetailViewController] = []
    var count = 0
    var viewTapGesture: UITapGestureRecognizer!
    
    // MARK: - Helper Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        navigationController?.isNavigationBarHidden = true
        configureMapView()
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
//        viewTapGesture.delegate = self
//        mapView.mapView.addSubview(clearView)
//        mapView.mapView.subviews[0].isUserInteractionEnabled = true
        view.addGestureRecognizer(viewTapGesture)
//        self.mapView.mapView.subviews[0].addGestureRecognizer(viewTapGesture)
//        print(mapView.mapView.subviews[0])
        
        
    }
    
    func getStoresData() {
        
        print("start get stores data..")
        storeModel = GetStoreInfo()
        storeModel.getStoreInfo { (snapShot) in
            for document in snapShot.documents {
                print(document.data())
                let storeData = document.data()
                guard let latitude = storeData["latitude"] as? Double, let longitude = storeData["longitude"] as? Double, let storeName = storeData["storeName"] as? String, let storeImage = storeData["storeImage"] as? String, let storeReview = storeData["storeImpression"] as? String, let userId = storeData["userId"] as? String else { return }
                self.configureMakerInMap(latitude: latitude, longitude: longitude, storeName: storeName, count: self.count, storename: storeName, storeReview: storeReview, storeImage: storeImage, userId: userId)
                self.count += 1
            }
        }
        
    }
    
    func configureMakerInMap(latitude: Double, longitude: Double, storeName: String, count: Int, storename: String, storeReview: String, storeImage: String, userId: String) {
        
        print("configure maker..")
        let position = CLLocationCoordinate2DMake(latitude, longitude)
        let marker = GMSMarker(position: position)
        marker.title = storeName
        marker.identifier = count
        marker.map = mapView.mapView
        

        self.storeModel.getPostUserInfo(userId: userId) { (snapShot) in
            let userInfo = snapShot.data()
            guard let postUserName = userInfo!["userName"] as? String, let postUserIcon = userInfo!["userImage"] as? String else { return }
            self.configureViewController(storeName: storeName, storeReview: storeReview, storeImage: storeImage, count: count, postUserName: postUserName, postUserIcon: postUserIcon)
        }
        
    }
    
    func configureViewController(storeName: String, storeReview: String, storeImage: String, count: Int, postUserName: String, postUserIcon: String) {
        
        storeDetailViewControllers.append(StoreDetailViewController(storeName: storeName, storeReview: storeReview, storeImage: storeImage, postUserName: postUserName,  postUserIcon: postUserIcon,count: count))
        
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
        let navStoreDetailViewController = UINavigationController(rootViewController: storeDetailViewControllers[marker.identifier])
        navStoreDetailViewController.modalPresentationStyle = .fullScreen
        present(navStoreDetailViewController, animated: true, completion: nil)
        print("did tap info window of maker..")
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return false
    }
    
}
