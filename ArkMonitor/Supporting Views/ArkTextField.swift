//
//  ArkTextField.swift
//  Dark
//
//  Created by Andrew on 2017-09-23.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit

class ArkTextField: UITextField {
    
    init(placeHolder: String) {
        super.init(frame: CGRect.zero)
        isUserInteractionEnabled = true
        textAlignment = .center
        autocapitalizationType = .none
        autocorrectionType     = .no
        spellCheckingType      = .no
        textColor = ArkPalette.accentColor
        tintColor = ArkPalette.accentColor
        adjustsFontSizeToFitWidth = true
        placeholder = placeHolder
        placeHolderTextColor = ArkPalette.textColor
        font = UIFont.systemFont(ofSize: 18.0, weight:  .semibold)
        
        let seperator = UIView()
        seperator.backgroundColor = ArkPalette.accentColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ArkServerTextField: UITextField {
    
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
        font = UIFont.systemFont(ofSize: 16.0, weight:  .semibold)
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
