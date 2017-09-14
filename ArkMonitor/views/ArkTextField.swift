//
//  ArkTextField.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-13.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class ArkTextField: UITextField {
    
    private var bottomSeparator: UIView!
    
    init(placeHolder: String) {
        super.init(frame: CGRect.zero)
        isUserInteractionEnabled = true
        bottomSeparator = UIView()
        bottomSeparator.backgroundColor = ArkPalette.textColor
        textAlignment = .center
        autocapitalizationType = .none
        autocorrectionType     = .no
        spellCheckingType      = .no
        textColor = ArkPalette.highlightedTextColor
        tintColor = ArkPalette.highlightedTextColor
        placeholder = placeHolder
        placeHolderTextColor = ArkPalette.textColor
        font = UIFont.systemFont(ofSize: 16.0)
        addSubview(bottomSeparator)
        bottomSeparator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
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
