//
//  ViewController.swift
//  ReminderNotifications
//
//  Created by Cameron Mcleod on 2019-07-24.
//  Copyright © 2019 Cameron Mcleod. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    private let locationNotificationScheduler = LocationNotificationScheduler()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationNotificationScheduler.delegate = self
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) {
            (granted, error) in
            if granted {
                print("yes")
            } else {
                print("No")
            }
        }
    }
    

    @IBAction func sendNotification(_ sender: Any) {
        
        let region = CLRegion.init()
        
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Mastery"
        content.subtitle = "Reminder"
        content.body = "you said you would do something Now!"
        
       

        
        let snoozeTaskAction = UNNotificationAction(identifier: "Snooze",
                                                title: "Snooze", options: [])
        let startTaskAction = UNNotificationAction(identifier: "StartTaskAction",
                                                title: "Start Task", options: [.foreground])
        
        let category = UNNotificationCategory(identifier: "MasteryReminderCategory",
                                              actions: [snoozeTaskAction,startTaskAction],
                                              intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
        content.categoryIdentifier = "MasteryReminderCategory"
        
        let imageName = "applelogo"
        guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") else { return }
        
        let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
        
        content.attachments = [attachment]
        
        // date trigger
        let date = Date(timeIntervalSinceNow: 5)
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        let triggerCalendar = UNCalendarNotificationTrigger(dateMatching: triggerDate,
                                                    repeats: false)
        
        //repeat daily
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
        let triggerCalendarDaily = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        // repeat weekly
        let triggerWeekly = Calendar.current.dateComponents([.weekday,.hour,.minute,.second,], from: date)
        let triggerCalendarWeekly = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)

        // trigger location based
        let triggerLocation = UNLocationNotificationTrigger(region:region, repeats:false)
        
        // time interval trigger
        let triggerInterval = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        // create requests
        
        let identifier = "MasteryLocalNotification"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: triggerCalendar)
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                // Something went wrong
            }
        })
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @IBAction func scheduleLocationNotification(_ sender: Any) {
        
        let notificationInfo = LocationNotificationInfo(notificationId: "LHL_notification_id",
                                                        locationId: "LHL_location_id",
                                                        radius: 500.0,
                                                        latitude: 49.281279,
                                                        longitude: -123.115005,
                                                        title: "Welcome to LightHouse Labs!",
                                                        body: "Tap to see more information",
                                                        data: ["location": "Lighthouse Labs Vancouver"])
        
        locationNotificationScheduler.requestNotification(with: notificationInfo)
        
    }
}

class MasterNotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Play sound and show alert to the user
        completionHandler([.alert,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Determine the user action
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Snooze":
            print("Snooze")
        case "StartTaskAction":
            print("Start Task Action")
        default:
            print("Unknown action")
        }
        completionHandler()
    }
    
}

extension ViewController: LocationNotificationSchedulerDelegate {
    
    func locationPermissionDenied() {
        let message = "The location permission was not authorized. Please enable it in Settings to continue."
        presentSettingsAlert(message: message)
    }
    
    func notificationPermissionDenied() {
        let message = "The notification permission was not authorized. Please enable it in Settings to continue."
        presentSettingsAlert(message: message)
    }
    
    func notificationScheduled(error: Error?) {
        if let error = error {
            let alertController = UIAlertController(title: "Notification Schedule Error",
                                                    message: error.localizedDescription,
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: "Notification Scheduled!",
                                                    message: "You will be notified when you are near the location!",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "LHL_notification_id" {
            let notificationData = response.notification.request.content.userInfo
            let message = "You have reached \(notificationData["location"] ?? "your location!")"
            
            let alertController = UIAlertController(title: "Welcome!",
                                                    message: message,
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true)
        }
        completionHandler()
    }
    
    private func presentSettingsAlert(message: String) {
        let alertController = UIAlertController(title: "Permissions Denied!",
                                                message: message,
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alertAction) in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings)
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        
        present(alertController, animated: true)
    }
}
