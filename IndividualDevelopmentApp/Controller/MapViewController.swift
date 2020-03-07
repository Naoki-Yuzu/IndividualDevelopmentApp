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
}

class MapViewController: UIViewController {
    
    // MARK: - Properties
    var mapView: MapView!
    var delegate: MapViewControllerDelegate?
    var storeModel: GetStoreInfo!
    var storeDetailViewControllers: [StoreDetailViewController] = []
    var count = 0
    var storeName = [String?]()
    var storeIamge = [String?]()
    var storeReview = [String?]()

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
        print("called configureUIView in MapViewController..")
            
        getStoresData()
        
    }
    
    func getStoresData() {
        
        print("start get stores data..")
        storeModel = GetStoreInfo()
        storeModel.getStoreInfo { (snapShot) in
            for document in snapShot.documents {
                print(document.data())
                let storeData = document.data()
                guard let latitude = storeData["latitude"] as? Double, let longitude = storeData["longitude"] as? Double, let storeName = storeData["storeName"] as? String, let storeImage = storeData["storeImage"] as? String, let storeReview = storeData["storeImpression"] as? String else { return }
//                self.storeName.append(storeName)
//                self.storeIamge.append(storeImage)
//                self.storeReview.append(storeReview)
                self.configureMakerInMap(latitude: latitude, longitude: longitude, storeName: storeName, count: self.count, storename: storeName, storeReview: storeReview, storeImage: storeImage)
                self.count += 1
            }
        }
        
    }
    
    func configureMakerInMap(latitude: Double, longitude: Double, storeName: String, count: Int, storename: String, storeReview: String, storeImage: String) {
        
        print("configure maker..")
        storeDetailViewControllers.append(StoreDetailViewController(storeName: storeName, storeReview: storeReview, storeImage: storeImage, count: count))
        let position = CLLocationCoordinate2DMake(latitude, longitude)
        let marker = GMSMarker(position: position)
        marker.title = storeName
        marker.snippet = "Hell World!!"
        marker.identifier = count
        marker.map = mapView.mapView
        
    }

}

extension MapViewController: MapViewDelegate {
    
    
    func showOrHideSideMenu() {
        print("came map view controller..")
        delegate?.showOrHideSideMenu()

    }
    
}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        let navStoreDetailViewController = UINavigationController(rootViewController: storeDetailViewControllers[marker.identifier])
        navStoreDetailViewController.modalPresentationStyle = .fullScreen
        present(navStoreDetailViewController, animated: true, completion: nil)
        print("did tap info window of maker..")
    }
    
}

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
