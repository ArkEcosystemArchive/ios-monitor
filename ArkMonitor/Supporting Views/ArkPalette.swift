//
//  ArkPalette.swift
//  Dark
//
//  Created by Andrew on 2017-09-20.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit

public struct ArkPalette {
    static public let backgroundColor          = UIColor(r: 0, g: 0, b: 0)
    static public let secondaryBackgroundColor = UIColor(r: 19, g: 19, b: 19)
    static public let tertiaryBackgroundColor  = UIColor(r: 42, g: 42, b: 42)
    static public let textColor                = UIColor(r: 119, g: 119, b: 125)
    static public let highlightedTextColor     = UIColor(r: 249, g: 247, b: 247)
    static public let accentColor              = UIColor(r: 0, g: 191, b: 192)

}

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}
