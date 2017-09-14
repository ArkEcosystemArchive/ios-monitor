//
//  ArkTextField.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-13.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class ArkTextField: UITextField {
    
    init(settings: Bool, placeHolder: String) {
        super.init(frame: CGRect.zero)
        isUserInteractionEnabled = true
        textAlignment          = .right
        autocapitalizationType = .none
        autocorrectionType     = .no
        spellCheckingType      = .no
        textColor = ArkPalette.accentColor
        tintColor = ArkPalette.accentColor
        placeholder = placeHolder
        placeHolderTextColor = ArkPalette.textColor
        font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
    }
    
    init(placeHolder: String) {
        super.init(frame: CGRect.zero)
        isUserInteractionEnabled = true
        textAlignment = .center
        autocapitalizationType = .none
        autocorrectionType     = .no
        spellCheckingType      = .no
        textColor = ArkPalette.accentColor
        tintColor = ArkPalette.accentColor
        placeholder = placeHolder
        placeHolderTextColor = ArkPalette.textColor
        font = UIFont.systemFont(ofSize: 18.0)
        font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITextField {
    var placeHolderTextColor: UIColor? {
        set {
            let placeholderText = self.placeholder != nil ? self.placeholder! : ""
            attributedPlaceholder = NSAttributedString(string:placeholderText, attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
        get{
            return self.placeHolderTextColor
        }
    }
}
