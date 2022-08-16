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

    private let courseJSONLoader = LoadingCourseJSON().courses
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let naverMapView = NMFNaverMapView(frame: view.frame)

        view.addSubview(naverMapView)
        navigationItem.title = "상세 코스"
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }

        // 지정 좌표로 시작 화면 띄우기
        let cameraUpdate = NMFCameraUpdate (
            scrollTo: NMGLatLng(
                lat: courseJSONLoader[1].course_pins[0].pin_x!,
                lng: courseJSONLoader[1].course_pins[0].pin_y!
            )
        )
        cameraUpdate.animation = .easeIn
        naverMapView.mapView.moveCamera(cameraUpdate)
        
        for pinNum in 0 ..< courseJSONLoader[1].course_pins.count {
            let marker = NMFMarker()

            marker.iconImage = NMFOverlayImage(
                image: UIImage(imageLiteralResourceName: SelectedTypes(rawValue: pinNum + 1)?
                        .selectedPinsImage(isSelecting: false) ?? ""))
            marker.position = NMGLatLng(
                lat: courseJSONLoader[1].course_pins[pinNum].pin_x ?? 0,
                lng: courseJSONLoader[1].course_pins[pinNum].pin_y ?? 0
            )
            marker.mapView = naverMapView.mapView
        }
    }
}

