//
//  LocationManager.swift
//  IntoHistory
//
//  Created by Yu ahyeon on 2022/08/13.
//

import Foundation
import CoreLocation
import UserNotifications

class LocationService: NSObject {
    
    static let shared = LocationService()
    var locationManager: CLLocationManager!
    
    private override init() {
        super.init()
        locationManager = CLLocationManager.init()
        locationManager.delegate = self
    }
    
    func registLocation() {
        let location = CLLocationCoordinate2D(latitude: 37.583262, longitude: 126.986834)
        //CLLocationCoordinate2D : 위치의 위도와 경도를 사용해 위치 좌표를 만듦 /latitude = 위도,longitude = 경도
        
        let region = CLCircularRegion(center: location, radius: 1.0, identifier: "id")
        //CLCircularRegion : 해당 좌표로부터 어느정도를 반경으로 잡을건지 설정 / 원형으로 반경을 잡음
        region.notifyOnExit = true
        region.notifyOnExit = true
        //해당 영역에 들어오고 나갈때 알림을 주는 코드
        
        locationManager.allowsBackgroundLocationUpdates = true
        // 백그라운드에서 계속 사용자 위치를 업데이트
        locationManager.pausesLocationUpdatesAutomatically = false
        // 위치 추척을 일시중지 할것인지 여부
        locationManager.startUpdatingLocation()
        // 위치 추적 시작
        locationManager.startMonitoring(for: region)
        // 특정 지역을 모니터링함(모든지역을 한번씩 모니터링해야함)
        print("region regist: \(region)")
    }
    
    func fireNotification(_ title: String = "Background Test", body: String){
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings{
            if $0.alertSetting == .enabled {
            //alertSetting이 .enabled(활성화)된 경우 알림을 줌
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body
                
                let uuidString = UUID().uuidString
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
                //트리거 - 일정 시간후에 알림을 줌
                let request = UNNotificationRequest(identifier: "test-\(uuidString)", content: content, trigger: trigger)
                //알림요청(예약)-> identifier: 알림을 구분할 수 있게해주는 식별자.. / content: 알림에 들어갈 내용 / 트리거: UserNotifications을 작동시킬 트리거
                notificationCenter.add(request, withCompletionHandler: { (error) in
                //예약한 알림을 센터에  추가하는 코드
                    if error != nil {
                        //에러..다루는 코드입력
                    }
                })
                
            }
        }
        
    }
}

extension LocationService: CLLocationManagerDelegate {
    func requestAlwaysLocation() {
        switch locationManager.authorizationStatus {
            //authorizationStatus : 앱이 위치서비스를 사용할 권한이 있는지 여부를 나타내는 값
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            //사용자가 아직 위치서비스를 사용여부 미선택 -> 승인요청띄우기
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            // 사용자가 앱 실행 시에만 위치 추적 허용 -> 승인요청 띄우기 (우린 백그라운드에서도 추적해야해서)
        case .authorizedAlways:
            registLocation()
            //항상 위치추적 허용 -> registLocation() 메서드 실행
        default:
            print("유효한 지역이 아님")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        //해당 지역이 모니터링 되고 있음을 delegate에게 알리는 메소드
        print("didStartMonitoringFor")
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        // delegate에게 해당 지역의 상태를 알려주는 메소드
        switch state {
        case .inside:
            print("들어옴")
            fireNotification("영웅의 길 정.복.완.료😎",body: "방문완료!")
        case .outside:
            print("나감")
//            fireNotification("나감",body: "인녕히 가세요")
        case .unknown: break
        }
        // 해당 지역에 들어오고 나가면 프린트로 찍힘
        
    }
    
}
