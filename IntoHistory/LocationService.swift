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
    var allRegions = [CLRegion]()
    let pinData = coreDataManager.pins
    var pinName = ""
    var currentPinData: PinEntity = coreDataManager.pins[0]
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
    
    private func makePinData(region: CLRegion) {
        
        let latStartIndex = region.identifier.index(region.identifier.startIndex, offsetBy: 35)
        let latEndIndex = region.identifier.index(region.identifier.startIndex, offsetBy: 44)
        let lngStartIndex = region.identifier.index(region.identifier.startIndex, offsetBy: 57)
        let lngEndIndex = region.identifier.index(region.identifier.startIndex, offsetBy: 67)
        
        for i in 0..<coreDataManager.pins.count {
            if Double(region.identifier[latStartIndex ..< latEndIndex]) == pinData[i].lat && Double(region.identifier[lngStartIndex ..< lngEndIndex]) == pinData[i].lng {
                currentPinData = pinData[i]
            }
        }
    }
    
    private func setLocationManager() {
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startUpdatingLocation()
    }
    
    private func evaluateClosestRegions() {
        var allDistance : [Double] = []
        
        for region in allRegions {
            let circularRegion = region as! CLCircularRegion
            let distance = currentLocation!.distance(from: CLLocation(latitude: circularRegion.center.latitude, longitude: circularRegion.center.longitude))
            allDistance.append(distance)
        }
        
        let distanceOfEachRegionToCurrentLocation = zip(allRegions, allDistance)
        
        let twentyNearbyRegions = distanceOfEachRegionToCurrentLocation
            .sorted{ prevDistance, nextDistance in return prevDistance.1 < nextDistance.1 }
            .prefix(20)
        
        for region in locationManager.monitoredRegions{
            locationManager.stopMonitoring(for: region)
        }
        
        twentyNearbyRegions.forEach{
            locationManager.startMonitoring(for: $0.0)
        }
    }
    
    private func makeNotification() {
        setLocationManager()
        for num in 0..<pinData.count {
            let lat = pinData[num].lat
            let long = pinData[num].lng
            pinName = pinData[num].pinName
            
            let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let region = CLCircularRegion(center: location, radius: 50.0, identifier: "id\(location)")
            region.notifyOnEntry = true
            allRegions.append(region)
        }
    }
    
    private func fireNotification(_ title: String = "Background Test", body: String, identifier: String){
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings{
            if $0.alertSetting == .enabled {
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body
                
                let identifier = identifier
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                notificationCenter.add(request, withCompletionHandler: { (error) in
                    if error != nil { }
                })
            }
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
            print("????????? ????????? ??????")
        }
    }

    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch state {
        case .inside:
            makePinData(region: region)
            fireNotification("\(currentPinData.pinName) ??????????????????",
                             body: "????????? ????????? ????????????\n???????????? ????????? ??????????????????????????", identifier: pinName)
            coreDataManager.updatePinIsVisited(pin: currentPinData)
        case .outside:
            print("??????")
        case .unknown: break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return };currentLocation = location
    }
}

