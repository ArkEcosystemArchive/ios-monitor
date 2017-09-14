//
//  ArkViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-13.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class ArkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ArkPalette.backgroundColor
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode                   = .always
        }
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: ArkPalette.accentColor]
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(colorsUpdated), name: NSNotification.Name(rawValue: ArkNotifications.colorUpdated.rawValue), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc public func colorsUpdated() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: ArkPalette.accentColor]
        }
        navigationController?.navigationBar.barTintColor  = ArkPalette.secondaryBackgroundColor
        navigationController?.navigationBar.tintColor     = ArkPalette.textColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: ArkPalette.accentColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20.0)]
        tabBarController?.tabBar.tintColor                = ArkPalette.accentColor
        tabBarController?.tabBar.unselectedItemTintColor  = ArkPalette.textColor
        tabBarController?.tabBar.barTintColor             = ArkPalette.secondaryBackgroundColor
    }
}
