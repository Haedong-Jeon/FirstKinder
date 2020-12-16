//
//  AppDelegate.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/11/30.
//

import UIKit
import IQKeyboardManager
import Firebase
import FirebaseMessaging
import UserNotificationsUI


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared().isEnabled = true
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOption) { (isSuccess, error) in
            guard isSuccess else {
                print("notification auth error! - \(String(describing: error))")
                return
            }
            print("notification auth success!")
        }
        application.registerForRemoteNotifications()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("fcm token is \(fcmToken)")
        FCMToken = fcmToken   
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

/*
 e0ciqxUIMU80vSwFduySYz:APA91bELmldFU0Q0EH45mrRCc8hnVvtLHCU5wPwNff7IKOqfFlnyhC2rnuWZtH92hZnIwWxC4Q1Jzr5oJE89v2LCIvmfhtq2fnxqRhXexaKHQMeOrCqmc4iel38OjCZUtZcF5L-9j6xi
 */
/*
 e0ciqxUIMU80vSwFduySYz:APA91bELmldFU0Q0EH45mrRCc8hnVvtLHCU5wPwNff7IKOqfFlnyhC2rnuWZtH92hZnIwWxC4Q1Jzr5oJE89v2LCIvmfhtq2fnxqRhXexaKHQMeOrCqmc4iel38OjCZUtZcF5L-9j6xi
 */
