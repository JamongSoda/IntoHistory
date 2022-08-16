//
//  LocationManager.swift
//  IntoHistory
//
//  Created by Yu ahyeon on 2022/08/13.
//

import Foundation
import CoreLocation
import UserNotifications
import UIKit

class LocationService: NSObject {

    static let shared = LocationService()
    var locationManager: CLLocationManager!
    let courseData = LoadingCourseJSON().courses.map{$0.course_pins}
    var arr = [(Double, Double)]()

    private override init() {
        super.init()
        locationManager = CLLocationManager.init()
        locationManager.delegate = self
    }

    func registLocation(lat: Double , long: Double) {
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = CLCircularRegion(center: location, radius: 100.0, identifier: "id\(location)")
        region.notifyOnExit = true
        region.notifyOnExit = true

        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startUpdatingLocation()
        locationManager.startMonitoring(for: region)
    }

    func fireNotification(_ title: String = "Background Test", body: String){
        let notificationCenter = UNUserNotificationCenter.current()

        notificationCenter.getNotificationSettings{
            if $0.alertSetting == .enabled {
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body

                let uuidString = UUID().uuidString
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
                let request = UNNotificationRequest(identifier: "test-\(uuidString)", content: content, trigger: trigger)
                notificationCenter.add(request, withCompletionHandler: { (error) in
                    if error != nil {
                        // error
                    }
                })

            }
        }
    }

    private func loadJSONData() {
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let context = appDelegate.persistentContainer.viewContext

          do {
              let course = try context.fetch(CourseEntity.fetchRequest()) as! [CourseEntity]
              let pin = try context.fetch(PinEntity.fetchRequest()) as! [PinEntity]
              let hero = try context.fetch(HeroEntity.fetchRequest()) as! [HeroEntity]

              pin.forEach {
                  arr.append(($0.lat,$0.lng))
              }

          } catch {
              print(error.localizedDescription)
          }
      }

    func makenogifitation() {
        self.loadJSONData()
        for i in 0..<arr.count {
            let lat = arr[i].0
            let long = arr[i].1
            registLocation(lat: lat, long: long)
        }
    }
}

extension LocationService: CLLocationManagerDelegate {

    func requestAlwaysLocation() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways:
            makenogifitation()
        default:
            print("유효한 지역이 아님")
        }
    }

    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {}

    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch state {
        case .inside:
            fireNotification("영웅의 길 정.복.완.료😎",body: "방문완료!\(region)")
        case .outside:
            print("나감")
        case .unknown: break
        }
        // 해당 지역에 들어오고 나가면 프린트로 찍힘
    }

//    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        print("들어옴 ]\(region)")
//        fireNotification("영웅의 길 정.복.완.료😎",body: "방문완료!\(region)")
//    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("위도: \(location.coordinate.latitude)")
            print("경도: \(location.coordinate.longitude)")
        }
    }

}
