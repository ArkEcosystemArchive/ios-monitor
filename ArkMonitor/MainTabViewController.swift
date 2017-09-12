//
//  MainTabViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor               = ArkColors.blue
        tabBar.unselectedItemTintColor = ArkColors.gray
        tabBar.isTranslucent           = true

        let homeViewController = HomeViewController()
        let nav1 = UINavigationController(rootViewController: homeViewController)
        nav1.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "homeUnfilled"), selectedImage: #imageLiteral(resourceName: "homeFilled"))
        
        let forgedBlocksViewController =  ForgedBlockViewController()
        let nav2 = UINavigationController(rootViewController: forgedBlocksViewController)
        nav2.tabBarItem = UITabBarItem(title: "Forged", image: #imageLiteral(resourceName: "hammerUnfilled"), selectedImage: #imageLiteral(resourceName: "hammerFilled"))
        
        let transactionVC = LastestTransactionsViewController()
        let nav3 = UINavigationController(rootViewController: transactionVC)
        nav3.tabBarItem = UITabBarItem(title: "Transactions", image: #imageLiteral(resourceName: "historyUnfilled"), selectedImage: #imageLiteral(resourceName: "historyFilled"))
        
        let delegatesViewController =  DelegateViewController()
        let nav4 = UINavigationController(rootViewController: delegatesViewController)
        nav4.tabBarItem = UITabBarItem(title: "Delegates", image: #imageLiteral(resourceName: "delegatesUnfilled"), selectedImage: #imageLiteral(resourceName: "delegatesFilled"))

        
        let miscViewController =  MiscViewController()
        let nav5 = UINavigationController(rootViewController: miscViewController)
        nav5.tabBarItem = UITabBarItem(title: "More", image: #imageLiteral(resourceName: "moreUnfilled"), selectedImage: #imageLiteral(resourceName: "moreFilled"))

        viewControllers = [nav1, nav2, nav3, nav4, nav5]
    }

}
