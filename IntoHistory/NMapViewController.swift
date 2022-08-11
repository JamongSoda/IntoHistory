//
//  NMapViewController.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/11.
//

import CoreLocation
import UIKit

import NMapsMap

class NMapViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        let naverMapView = NMFNaverMapView(frame: view.frame)
        view.addSubview(naverMapView)

        naverMapView.showZoomControls = false
        naverMapView.showLocationButton = true

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("위치서비스 on")
            locationManager.startUpdatingLocation()
        } else {
            print("위치서비스 off")
        }
    }
}
