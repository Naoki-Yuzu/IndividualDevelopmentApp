//
//  MapView.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit
import GoogleMaps

protocol MapViewDelegate {
    func showOrHideSideMenu()
}

class MapView: UIView {
    
    // MARK: - Properties
    var sideMenuButton: UIButton!
    var mapView: GMSMapView!
    var delegate: MapViewDelegate?
    var locationManager: CLLocationManager!
    let defaultLocation = CLLocation(latitude: 35.6809591, longitude: 139.7673068) // 東京駅
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        print("init")
        
        configureMap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    override func updateConstraints() {
        super.updateConstraints()
        print("map view auto layout..")
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mapView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        sideMenuButton.frame = CGRect(x: self.bounds.origin.x + 50, y: self.bounds.origin.y + 50, width: 40, height: 40)
    }
    
    private func configureMap() {
        print("set up map..")
        // GoogleMapの初期位置(仮で東京駅付近に設定)
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude, zoom: 15)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        print("camera of map view \(mapView.camera)")
        mapView.isMyLocationEnabled = true
        self.addSubview(mapView)
        mapView.isHidden = true
        
        getUserLocation()
        configureSideMenuButton()
    }
    
    private func getUserLocation() {
        
        print("get user location..")
        locationManager = CLLocationManager()
        locationManager.distanceFilter = 0.5
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        // CLLocationManagerDelegateのdidChangeAuthorizationが起動
        
    }
    
    private func configureSideMenuButton() {
        
        sideMenuButton = UIButton()
        sideMenuButton.setImage(UIImage(named: "hamburger-icon"), for: .normal)
        sideMenuButton.imageView?.contentMode = .scaleAspectFill
        sideMenuButton.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 240/255, alpha: 0.8)
        sideMenuButton.layer.cornerRadius = 8
        sideMenuButton.addTarget(self, action: #selector(showOrHideSideMenu), for: .touchUpInside)
        self.addSubview(sideMenuButton)
        
    }
    
    // MARK: - Selector
    @objc func showOrHideSideMenu() {
        print("tapped..")
        delegate?.showOrHideSideMenu()
    }

}

// MARK: - Delegate
extension MapView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("did update locations")
        let location = locations.first
        let latitude = location?.coordinate.latitude ?? 35.6809591 // nilだったら東京駅の緯度
        let longitude = location?.coordinate.longitude ?? 139.7673068 // nilだったら東京駅の経度
        print("latitude\(latitude)\nlongitude\(longitude)")
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("did change authorization..")
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            print("authorizedWhenInUse..")
            locationManager.startUpdatingLocation()
            // CLLocationManagerDelegateのdidUpdateLocationsが起動
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            // CLLocationManagerDelegateのdidUpdateLocationsが起動
            break
        case .restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
        default:
            break
        
        }
    }
    
}
