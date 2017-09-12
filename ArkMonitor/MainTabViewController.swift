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
        
        tabBar.tintColor = ArkColors.blue
        tabBar.unselectedItemTintColor = ArkColors.gray
        tabBar.isTranslucent = true

        let homeViewController = HomeViewController1()
        let nav1 = UINavigationController(rootViewController: homeViewController)
        nav1.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "homeUnfilled"), selectedImage: #imageLiteral(resourceName: "homeFilled"))
        
        let forgedBlocksViewController =  ForgedBlocksViewController()
        forgedBlocksViewController.tabBarItem = UITabBarItem(title: "Forged", image: #imageLiteral(resourceName: "hammerUnfilled"), selectedImage: #imageLiteral(resourceName: "hammerFilled"))
        
        let latestTransactionsViewController = LatestTransactionsViewController()
        latestTransactionsViewController.tabBarItem = UITabBarItem(title: "Transactions", image: #imageLiteral(resourceName: "ic_history_black_36dp"), selectedImage: nil)
        
        let delegatesViewController =  DelegatesViewController()
        delegatesViewController.tabBarItem = UITabBarItem(title: "Delegates", image: #imageLiteral(resourceName: "ic_group_black_36dp"), selectedImage: nil)

        
        
        let peersViewController =  PeersViewController()
        peersViewController.tabBarItem = UITabBarItem(title: "More", image: #imageLiteral(resourceName: "moreUnfilled"), selectedImage: #imageLiteral(resourceName: "moreFilled"))

        
        viewControllers = [nav1, forgedBlocksViewController, latestTransactionsViewController, delegatesViewController, peersViewController]
        
    }

}
