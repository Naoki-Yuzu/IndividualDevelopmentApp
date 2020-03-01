//
//  MapViewController.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

protocol MapViewControllerDelegate {
    func showOrHideSideMenu()
}

class MapViewController: UIViewController {
    
    // MARK: - Properties
    var mapView: UIView!
    var delegate: MapViewControllerDelegate?

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
        mapView = localMapview
        view.addSubview(mapView)
        print("called configureUIView in MapViewController..")
        
    }

}

extension MapViewController: MapViewDelegate {
    
    func showOrHideSideMenu() {
        print("came map view controller..")
        delegate?.showOrHideSideMenu()
    }
    
}
