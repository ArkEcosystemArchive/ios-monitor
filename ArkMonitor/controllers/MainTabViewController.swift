//
//  MainTabViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        delegate                       = self
        tabBar.tintColor               = ArkPalette.accentColor
        tabBar.unselectedItemTintColor = ArkPalette.textColor
        tabBar.barTintColor            = ArkPalette.secondaryBackgroundColor
        tabBar.isTranslucent           = true

        let homeViewController = HomeViewController()
        let nav1 = UINavigationController(rootViewController: homeViewController)
        nav1.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "homeUnfilled"), selectedImage: #imageLiteral(resourceName: "homeFilled"))
        
        let settingVC = SettingSelectionViewController()
        let nav2 = UINavigationController(rootViewController: settingVC)
        nav2.tabBarItem = UITabBarItem(title: "Server", image: #imageLiteral(resourceName: "hammerUnfilled"), selectedImage: #imageLiteral(resourceName: "hammerFilled"))
        
        let transactionVC = LastestTransactionsViewController()
        let nav3 = UINavigationController(rootViewController: transactionVC)
        nav3.tabBarItem = UITabBarItem(title: "Transactions", image: #imageLiteral(resourceName: "historyUnfilled"), selectedImage: #imageLiteral(resourceName: "historyFilled"))
        
        let delegatesViewController =  DelegateViewController()
        let nav4 = UINavigationController(rootViewController: delegatesViewController)
        nav4.tabBarItem = UITabBarItem(title: "Delegates", image: #imageLiteral(resourceName: "delegatesUnfilled"), selectedImage: #imageLiteral(resourceName: "delegatesFilled"))

        
        let miscViewController =  MiscViewController()
        let nav5 = UINavigationController(rootViewController: miscViewController)
        nav5.tabBarItem = UITabBarItem(title: "More", image: #imageLiteral(resourceName: "moreUnfilled"), selectedImage: #imageLiteral(resourceName: "moreFilled"))

        viewControllers = [nav1, nav2, nav4, nav3, nav5]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewController.viewDidAppear(true)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        ArkHaptics.selectionChanged()
    }
}
