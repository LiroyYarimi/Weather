//
//  AppDelegate.swift
//  Weather
//
//  Created by liroy yarimi on 25.5.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //1
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:  [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("didFinishLaunchingWithOptions")
        return true
    }
    //after home button pressed
//1
    func applicationWillResignActive(_ application: UIApplication) {
        print("applicationWillResignActive")
    }
//2
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
    }

    //after return to the app
    //1
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
    }

    //2
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
    }


}

