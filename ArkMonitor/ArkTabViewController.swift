// Copyright (c) 2016 Ark
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
