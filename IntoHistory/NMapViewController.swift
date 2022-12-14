//
//  NMapViewController.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/11.
//
import CoreLocation
import UIKit

import NMapsMap

let naverMapView = NMFNaverMapView()

class NMapViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: - Property
    var pinlines = [NMGLatLng()]
    var booleanArray = [Bool]()
    var markers = [NMFMarker()]
    var locationManager = CLLocationManager()

    // MARK: - View

    private let hStackView: UIStackView = {
        $0.axis = .horizontal
        $0.backgroundColor = .white
        return $0
    }(UIStackView())

    private let vStackView: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())

    private let numberImage: UIImageView = {
        $0.image = UIImage(named: SelectedTypes(rawValue: 1)?.selectedPinsImage(isVisited: false, isSelected: false) ?? "")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let titleLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    private let addressLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .light)
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()

        naverMapView.frame = view.frame
        naverMapView.showLocationButton = true
        naverMapView.showZoomControls = false

        view.addSubview(naverMapView)
        naverMapView.addSubview(hStackView)

        hStackView.addArrangedSubview(numberImage)
        hStackView.addArrangedSubview(vStackView)

        vStackView.addArrangedSubview(titleLabel)
        vStackView.addArrangedSubview(addressLabel)

        naverMapView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )

        hStackView.anchor(
            left: naverMapView.leftAnchor,
            bottom: naverMapView.bottomAnchor,
            right: naverMapView.rightAnchor,
            paddingLeft: 16,
            paddingBottom: 40,
            paddingRight: 16,
            width: UIScreen.main.bounds.width,
            height: 90
        )

        hStackView.uiViewShadow(backgroundView: hStackView)

        numberImage.anchor(
            top: hStackView.topAnchor,
            left: hStackView.leftAnchor,
            bottom: hStackView.bottomAnchor,
            right: vStackView.leftAnchor,
            paddingLeft: 30,
            paddingBottom: 30,
            paddingRight: 15,
            width: 26,
            height: 26
        )

        vStackView.anchor(
            top: hStackView.topAnchor,
            bottom: hStackView.bottomAnchor,
            right: hStackView.rightAnchor,
            paddingTop: 25,
            paddingBottom: 25,
            paddingRight: 30
        )

        // MARK: - 맵뷰 최초 화면좌표

        let cameraUpdate = NMFCameraUpdate (
            scrollTo: NMGLatLng(

                lat: coreDataManager.coursePins[0].lat,
                lng: coreDataManager.coursePins[0].lng

            )
        )

        cameraUpdate.animation = .easeIn
        naverMapView.mapView.moveCamera(cameraUpdate)

        // MARK: - 마커(핀) 디폴트 이름 및 주소

        titleLabel.text = coreDataManager.coursePins[0].pinName
        addressLabel.text = coreDataManager.coursePins[0].address
        
        // MARK: - 경로 표시

        for pinNum in 0..<coreDataManager.coursePins.count {

            markers.append(NMFMarker())
            booleanArray.append(false)
            booleanArray[0] = true

            // MARK: - 마커 디폴트 이미지

            markers[pinNum].iconImage = NMFOverlayImage(
                image: UIImage(imageLiteralResourceName: SelectedTypes(rawValue: pinNum + 1)?
                    .selectedPinsImage(isVisited: coreDataManager.coursePins[pinNum].isVisited, isSelected: booleanArray[pinNum]) ?? ""))

            // MARK: - 마커 위치

            markers[pinNum].position = NMGLatLng(
                lat: coreDataManager.coursePins[pinNum].lat,
                lng: coreDataManager.coursePins[pinNum].lng
            )

            // MARK: - 마커 누르면 이미지, 텍스트 변경

            let handler = { [self] (overlay: NMFOverlay) -> Bool in

                numberImage.image = UIImage(named: SelectedTypes(rawValue: pinNum + 1)?
                    .selectedPinsImage(isVisited: false, isSelected: false) ?? "")
                
                titleLabel.text = coreDataManager.coursePins[pinNum].pinName
                addressLabel.text = coreDataManager.coursePins[pinNum].address

                booleanArray[pinNum].toggle()

                for count in 0..<booleanArray.count {
                    if pinNum != count {
                        booleanArray[count] = false
                    }

                    markers[count].mapView = nil
                    
                    markers[count].iconImage = NMFOverlayImage(
                        image: UIImage(imageLiteralResourceName: SelectedTypes(rawValue: count + 1)?
                            .selectedPinsImage(isVisited: coreDataManager.coursePins[count].isVisited, isSelected: booleanArray[count]) ?? ""))

                    markers[count].mapView = naverMapView.mapView
                }
                
                if booleanArray[pinNum] {
                    hStackView.isHidden = false
                } else {
                    hStackView.isHidden = true
                }
                return true
            }
            markers[pinNum].touchHandler = handler
            markers[pinNum].mapView = naverMapView.mapView

        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        markers.forEach {
            $0.mapView = nil
        }
        naverMapView.removeFromSuperview()
        hStackView.removeFromSuperview()
    }

    // MARK: - Method

    func attribute() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.navigationBar.prefersLargeTitles = false

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}
