//
//  AppDelegate.swift
//  ArkMonitor
//
//  Created by Victor Lins on 22/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = ArkPalette.backgroundColor
        window?.makeKeyAndVisible()
        
        setNavigationBarStyle()

        let newVC = MainTabViewController()
        self.window?.rootViewController = newVC
        self.window?.makeKeyAndVisible()
        
        ArkDataManager.shared.updateData()
        
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
    
    private func setNavigationBarStyle() {
        if isDarkMode == true {
            UIApplication.shared.statusBarStyle = .lightContent
        } else {
            UIApplication.shared.statusBarStyle = .default
        }
        UINavigationBar.appearance().barTintColor  = ArkPalette.navigationBarColor
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor     = ArkPalette.accentColor
        UINavigationBar.appearance().shadowImage   = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: ArkPalette.accentColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20.0)]

    }
    
    public func updateColors() {
        setNavigationBarStyle()
    }
}

