//
//  ArkColors.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

var isDarkMode: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "isDarkMode")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "isDarkMode")
        UserDefaults.standard.synchronize()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.updateColors()
        ArkNotificationManager.postNotification(.colorUpdated)
    }
}

public struct ArkPalette {
    
    static public var fontWeight: UIFont.Weight {
        if isDarkMode == false {
            return .regular
        } else {
            return .semibold
        }
    }
    
    static public var backgroundColor: UIColor {
        if isDarkMode == false {
            return UIColor(r: 235, g: 235, b: 235)
        } else {
            return UIColor(r: 0, g: 0, b: 0)
        }
    }
    
    static public var secondaryBackgroundColor: UIColor {
        if isDarkMode == false {
            return UIColor(r: 255, g: 255, b: 255)
        } else {
            return UIColor(r: 19, g: 19, b: 19)
        }
    }
    
    static public var navigationBarColor: UIColor {
        if isDarkMode == false {
            return UIColor(r: 245, g: 245, b: 245)
        } else {
            return UIColor(r: 19, g: 19, b: 19)
        }
    }
    
    static public var tertiaryBackgroundColor: UIColor {
        if isDarkMode == false {
            return UIColor(r: 200, g: 199, b: 204)
        } else {
            return UIColor(r: 42, g: 42, b: 42)
        }
    }
    
    static public var textColor: UIColor {
        if isDarkMode == false {
            return UIColor(r: 144, g: 143, b: 139)
        } else {
            return UIColor(r: 119, g: 119, b: 125)
        }
    }
    
    static public var highlightedTextColor: UIColor {
        if isDarkMode == false {
            return UIColor(r: 0, g: 0, b: 0)
        } else {
            return UIColor(r: 249, g: 247, b: 247)
        }
    }
    
    static public var accentColor: UIColor {
        if isDarkMode == false {
            return UIColor(r: 0, g: 104, b: 222)
        } else {
            return UIColor(r: 0, g: 191, b: 192)
        }
    }
}

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}
