//
//  ArkTabViewController.swift
//  Dark
//
//  Created by Andrew on 2017-09-20.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit

class ArkTabViewController: UITabBarController, UITabBarControllerDelegate {
    
    let transitionDelegate = AccountTransitionDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate                       = self
        tabBar.tintColor               = ArkPalette.accentColor
        if #available(iOS 10.0, *) {
            tabBar.unselectedItemTintColor = ArkPalette.textColor
        } 
        tabBar.barTintColor            = ArkPalette.backgroundColor
        tabBar.isTranslucent           = true
        
        let homeViewController = HomeViewController()
        let homeNav = ArkNavigationViewController(rootViewController: homeViewController)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "homeFilled"), selectedImage: nil)
        
        let myDelegateVieController = MyDelegateViewController()
        let myDelegateNav = ArkNavigationViewController(rootViewController: myDelegateVieController)
        myDelegateNav.tabBarItem = UITabBarItem(title: "Delegate", image: #imageLiteral(resourceName: "delegatesFilled"), selectedImage: nil)
        
        let explorerVC = ExplorerViewController()
        let explorerNav = ArkNavigationViewController(rootViewController: explorerVC)
        explorerNav.tabBarItem = UITabBarItem(title: "Explorer", image: #imageLiteral(resourceName: "explorerIcon"), selectedImage: nil)


        let delegatesViewController =  DelegateListViewController()
        let delegateNav = ArkNavigationViewController(rootViewController: delegatesViewController)
        delegateNav.tabBarItem = UITabBarItem(title: "Delegates", image: #imageLiteral(resourceName: "delegateList"), selectedImage: nil)
        
        
        let settingsVC =  SettingsViewController()
        let miscNav = ArkNavigationViewController(rootViewController: settingsVC)
        miscNav.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "settings"), selectedImage: nil)
        
        viewControllers = [homeNav, myDelegateNav, delegateNav, explorerNav, miscNav]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if ArkDataManager.currentAddress == nil && ArkDataManager.currentPublickey == nil {
            let vc = AccountViewController()
            vc.transitioningDelegate = transitionDelegate
            present(vc, animated: true, completion: nil)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(showLogin), name: NSNotification.Name(rawValue: ArkNotifications.accountLogout.rawValue), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func showLogin() {
        let vc = AccountViewController()
        vc.transitioningDelegate = transitionDelegate
        present(vc, animated: true) {
            self.selectedIndex = 0
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewController.viewDidAppear(true)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //ArkHaptics.selectionChanged()
    }
}
