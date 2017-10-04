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
