//
//  AppDelegate.swift
//  IntoHistory
// 
//  Created by 김민택 on 2022/08/05.
//

import CoreData
import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let center = UNUserNotificationCenter.current();
        center.delegate = self
        
        if #available(iOS 14, *){
            center.requestAuthorization(options: [.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        if response.notification.request.content.body == "그들이 지켜낸 대한민국\n우리들의 영웅을 기억해주세요🇰🇷" {
//            guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else {
//                return
//            }
//           if let navController = rootViewController as? UINavigationController{
//               navController.pushViewController(MainViewController(), animated: true)
//            }
//        }
    }
}
