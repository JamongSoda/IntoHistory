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
    var latlongArray = [(lat: Double, long: Double)]()

    var allRegions = [CLRegion]()
    var currentLocation : CLLocation?{
        didSet{
            evaluateClosestRegions()
        }
    }
    
    private override init() {
        super.init()
        locationManager = CLLocationManager.init()
        locationManager.delegate = self
    }

    
    func registLocation(lat: Double , long: Double) {
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startUpdatingLocation()
    }
    
    func evaluateClosestRegions() {
        var allDistance : [Double] = []

           for region in allRegions{
               let circularRegion = region as! CLCircularRegion
               let distance = currentLocation!.distance(from: CLLocation(latitude: circularRegion.center.latitude, longitude: circularRegion.center.longitude))
               allDistance.append(distance)
           }
      
           let distanceOfEachRegionToCurrentLocation = zip(allRegions, allDistance)

           let twentyNearbyRegions = distanceOfEachRegionToCurrentLocation
               .sorted{ tuple1, tuple2 in return tuple1.1 < tuple2.1 }
               .prefix(20)


           for region in locationManager.monitoredRegions{
               locationManager.stopMonitoring(for: region)
           }

           twentyNearbyRegions.forEach{
               locationManager.startMonitoring(for: $0.0)
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
                  latlongArray.append(($0.lat, $0.lng))
              }

          } catch {
              print(error.localizedDescription)
          }
      }

    func makeNotification() {
        self.loadJSONData()
        for i in 0..<latlongArray.count {
            let lat = latlongArray[i].lat
            let long = latlongArray[i].long
            registLocation(lat: lat, long: long)

            let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let region = CLCircularRegion(center: location, radius: 50.0, identifier: "id\(location)")
            region.notifyOnEntry = true
            allRegions.append(region)
        }
    }
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
                    if error != nil { }
                })
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
            makeNotification()
        default:
            print("유효한 지역이 아님")
        }
    }

    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch state {
        case .inside:
            fireNotification("영웅의 길 정.복.완.료😎",body: "방문완료!\(region)")
        case .outside:
            print("나감")
        case .unknown: break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return };currentLocation = location
    }
}
