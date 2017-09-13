//
//  ArkActivityView.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import NotificationBannerSwift

public struct ArkActivityView  {
    static private let activityData = ActivityData(type: NVActivityIndicatorType.lineScale)

    static public func startAnimating() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    static public func stopAnimating() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    static public func showMessage(_ text: String) {
        let banner = StatusBarNotificationBanner(title: text, style: .warning, colors: CustomBannerColors())
        banner.show()
    }
}

fileprivate class CustomBannerColors: BannerColorsProtocol {
    
    func color(for style: BannerStyle) -> UIColor {
        switch style {
        case .danger:
            return ArkColors.gray
        case .info:     // Your custom .info color
            return ArkColors.gray
        case .none:     // Your custom .none color
            return ArkColors.gray
        case .success:  // Your custom .success color
            return ArkColors.gray
        case .warning:  // Your custom .warning color
            return ArkColors.gray
        }
    }
}

