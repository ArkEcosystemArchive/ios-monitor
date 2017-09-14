//
//  ArkColors.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

let isDarkMode = true

public struct ArkPalette {
    
    static public var backgroundColor: UIColor {
        if isDarkMode == false {
            return UIColor(r: 202, g: 202, b: 202)
        } else {
            return UIColor(r: 0, g: 0, b: 0)
        }
    }
    
    static public var secondaryBackgroundColor: UIColor {
        if isDarkMode == false {
            return UIColor(r: 210, g: 210, b: 210)
        } else {
            return UIColor(r: 19, g: 19, b: 19)
        }
    }
    
    static public var tertiaryBackgroundColor: UIColor {
        if isDarkMode == false {
            return UIColor(r: 188, g: 187, b: 193)
        } else {
            return UIColor(r: 42, g: 42, b: 42)
        }
    }
    
    static public var textColor: UIColor {
        if isDarkMode == false {
            return UIColor(r: 130, g: 130, b: 136)
        } else {
            return UIColor(r: 119, g: 119, b: 125)
        }
    }
    
    static public var highlightedTextColor: UIColor {
        if isDarkMode == false {
            return UIColor(r: 57, g: 57, b: 57)
        } else {
            return UIColor(r: 249, g: 247, b: 247)
        }
    }
    
    static public var accentColor: UIColor {
        if isDarkMode == false {
            return UIColor(r: 0, g: 191, b: 192)
        } else {
            return UIColor(r: 79, g: 78, b: 254)
        }
    }
}

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}
