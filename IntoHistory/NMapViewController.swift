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

    // MARK: - Property
    
    var locationManager = CLLocationManager()
    let infoWindow = NMFInfoWindow()
    let dataSource = NMFInfoWindowDefaultTextSource.data()
    var courseArr2: CourseEntity?
    var pinArr: [PinEntity]?
//    var coursePins: [CoursePins]?
    
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
        $0.image = UIImage(named: SelectedTypes(rawValue: 1)?.selectedPinsImage(isSelecting: false) ?? "")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let titleLabel: UILabel = {
        $0.text = "테스트"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let addressLabel: UILabel = {
        $0.text = "주소"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .light)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
//    let
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        guard let courseArr2 = courseArr2 else { return }
//        coreDataManager.loadCoursePinData(courseID: Int(courseArr2.cid))
        attribute()
//        print(coreDataManager.coursePins)
//        detailCourseVC.courseArr1 = courseEntity
//        nMapVC.courseArr2 = courseEntity
        
        
        let naverMapView = NMFNaverMapView(frame: view.frame)
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
        
        // 지정 좌표로 시작 화면 띄우기
        let cameraUpdate = NMFCameraUpdate (
            scrollTo: NMGLatLng(
                lat: pinArr?[0].lat ?? 35.0,
                lng: pinArr?[0].lng ?? 127.0
//                lat: 35,
//                lng: 127
            )
        )
        cameraUpdate.animation = .easeIn
        naverMapView.mapView.moveCamera(cameraUpdate)
//
        titleLabel.text = pinArr?[0].pinName ?? ""
        addressLabel.text = pinArr?[0].address ?? ""
        
        var booleanArray = [Bool]()
        var markers = [NMFMarker()]
        print(pinArr)
        print("안~~~~녕안~~~~녕안~~~~녕안~~~~녕안~~~~녕안~~~~녕안~~~~녕안~~~~녕안~~~~녕안~~~~녕안~~~~녕안~~~~녕안~~~~녕안~~~~녕안~~~~녕")
        for pinNum in 0 ..< 10 {

            markers.append(NMFMarker())
            booleanArray.append(false)
            booleanArray[0] = true
            
            // MARK: - 마커 디폴트 이미지
            
            markers[pinNum].iconImage = NMFOverlayImage(
                image: UIImage(imageLiteralResourceName: SelectedTypes(rawValue: pinNum + 1)?
                        .selectedPinsImage(isSelecting: false) ?? ""))
            
            // MARK: - 마커 위치
            
            markers[pinNum].position = NMGLatLng(
                lat: pinArr?[pinNum].lat ?? 35.0,
                lng: pinArr?[pinNum].lng ?? 127.0
            )
            
            // MARK: - 마커 누르면 이미지, 텍스트 변경
            
            let handler = { [self] (overlay: NMFOverlay) -> Bool in
                
                booleanArray[pinNum].toggle()
                numberImage.image = UIImage(named: SelectedTypes(rawValue: pinNum + 1)?.selectedPinsImage(isSelecting: false) ?? "")
                titleLabel.text = coreDataManager.coursePins[pinNum].pinName
                addressLabel.text = coreDataManager.coursePins[pinNum].address
                            
                if booleanArray[pinNum] {   
                    hStackView.isHidden = false
                } else {
                    hStackView.isHidden = true
                }
                
                for count in 0..<booleanArray.count {
                    if pinNum != count {
                        booleanArray[count] = false
                    }
                    
                    markers[count].mapView = nil
                    
                    markers[count].iconImage = NMFOverlayImage(
                        image: UIImage(imageLiteralResourceName: SelectedTypes(rawValue: count + 1)?
                            .selectedPinsImage(isSelecting: booleanArray[count]) ?? ""))
                    markers[count].mapView = naverMapView.mapView
                }
                return true
            }
            markers[pinNum].touchHandler = handler
            markers[pinNum].mapView = naverMapView.mapView
        }
    }
    
    // MARK: - Method
    
    @objc private func didTapRightBarButton() {
        navigationController?.popToRootViewController(animated: true)
        let beforeVC = DetailCourseViewController()
        beforeVC.view.backgroundColor = .white
        navigationController?.pushViewController(beforeVC, animated: false)
    }
    func attribute() {
        view.backgroundColor = .white
        navigationItem.title = "상세 코스"
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "list.bullet"),
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButton)
        )
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }

    }
}

