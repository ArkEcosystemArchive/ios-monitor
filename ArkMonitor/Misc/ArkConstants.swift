//
//  ArkConstants.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

public let _screenWidth    = UIScreen.main.bounds.width
public let _screenHeight   = UIScreen.main.bounds.height

public func _navHeight(_ vc: UIViewController) -> CGFloat {
    let statusBar = UIApplication.shared.statusBarFrame.height
    if let navController = vc.navigationController {
        return navController.navigationBar.frame.height + statusBar
    } else {
        return statusBar
    }
}
