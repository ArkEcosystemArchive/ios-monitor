//
//  ArkActivityView.swift
//  Dark
//
//  Created by Andrew on 2017-09-29.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import SwiftyArk

public struct ArkActivityView  {
    
    static public var lastNetworkMessageDate: Date?
    
    static public func checkNetworkError(_ error: Error?) {
        guard let currentError = error as? ApiError else {
            return
        }
        
        if currentError == ApiError.networkError {
            if let last = lastNetworkMessageDate {
                let now = Date()
                if now.timeIntervalSince(last) > 10.0 {
                    showNoNetworkMessage()
                    lastNetworkMessageDate = now
                }
            } else {
                showNoNetworkMessage()
                lastNetworkMessageDate = Date()
            }
        }
    }
    
    static private func showNoNetworkMessage() {
        let banner = StatusBarNotificationBanner(title: "No Network Detected", style: .warning, colors: CustomBannerColors())
        banner.duration = 6.0
        banner.show()
    }

    static public func showMessage(_ text: String, style: BannerStyle) {
        let banner = StatusBarNotificationBanner(title: text, style: style, colors: CustomBannerColors())
        banner.duration = 2.0
        banner.show()
    }
    
    
    
    
    
}

fileprivate class CustomBannerColors: BannerColorsProtocol {
    
    func color(for style: BannerStyle) -> UIColor {
        switch style {
        case .danger:
            return ArkPalette.textColor
        case .info:     // Your custom .info color
            return ArkPalette.textColor
        case .none:     // Your custom .none color
            return ArkPalette.textColor
        case .success:  // Your custom .success color
            return ArkPalette.accentColor
        case .warning:  // Your custom .warning color
            return ArkPalette.textColor
        }
    }
}

