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

