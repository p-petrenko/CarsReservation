//
//  AppDelegate.swift
//  CarsReservation
//
//  Created by Polina Petrenko on 14.06.17.
//  Copyright © 2017 Polina Petrenko. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var carsArray: [Car]!
    var chosenCarIndex: Int!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(Constants.GoogleAPIKey)
        
        carsArray = [Car]()
        for number in 1...10 {
            let car = Car(
                image: UIImage(named: "LimousineCar\(number)"),
                brand: "Марка \(number)",
                model: "Модель \(number)",
                plateNumber: "Гос. номер \(number)",
                location: chooseRandomCarLocation())
            carsArray.append(car)
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func chooseRandomCarLocation() -> CarLocation {
        let randomLatitude = CLLocationDegrees(randomDouble(min: Constants.KaliningradMinLatitude, max: Constants.KaliningradMaxLatitude))
        let randomLogitude = CLLocationDegrees(randomDouble(min: Constants.KaliningradMinLongitude, max: Constants.KaliningradMaxLongitude))
        return CarLocation(latitude: randomLatitude, longitude: randomLogitude)
    }
    
    func randomDouble(min: Double, max: Double) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
    
}

