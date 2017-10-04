//
//  ArkViewController.swift
//  Dark
//
//  Created by Andrew on 2017-09-22.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyArk

class ArkViewController: UIViewController {
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ArkPalette.backgroundColor
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: ArkPalette.accentColor]
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode                   = .always
        }
        
        navigationController?.navigationBar.barTintColor  = ArkPalette.backgroundColor
        navigationController?.navigationBar.tintColor     = ArkPalette.accentColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: ArkPalette.accentColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20.0)]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
