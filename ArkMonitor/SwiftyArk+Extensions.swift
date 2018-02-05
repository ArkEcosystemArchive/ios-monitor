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

import Foundation
import SwiftyArk


public let _screenWidth  = UIScreen.main.bounds.width
public let _screenHeight = UIScreen.main.bounds.height

extension Transaction {
    
    enum TransacionStatus {
        case sent
        case received
        case vote
        case unknown
    }
    
    func status() -> TransacionStatus {
        guard let myAddress = ArkDataManager.manager.settings?.address else {
            return .unknown
        }
        
        if type == 3 {
            return .vote
        }
        
        if recipientId == myAddress {
            return .received
        } else if senderId == myAddress {
            return .sent
        } else {
            return .unknown
        }
    }
}

extension Double {
    
    func formatString(_ decimalPoints: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = decimalPoints
        formatter.maximumFractionDigits = decimalPoints
        let number = NSNumber(value: self)
        return formatter.string(from: number) ?? "\(self)"
    }
}

extension Date {
    var fullStyleDateString: String {
        let formatterLongDate = DateFormatter()
        formatterLongDate.dateStyle = .full
        
        return formatterLongDate.string(from: self)
    }
    
    var longStyleDateString: String {
        let formatterLongDate = DateFormatter()
        formatterLongDate.dateFormat = "MMM dd, hh:mm a"
        
        return formatterLongDate.string(from: self)
    }
    
    
    var shortDateOnlyString: String {
        let formatterShortDate = DateFormatter()
        
        formatterShortDate.dateFormat = "dd/MM/yy"
        
        
        return formatterShortDate.string(from: self)
    }
}

func delay(_ delay: Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}

extension UISearchBar {
    
    public func updateColors() {
        backgroundColor = ArkPalette.backgroundColor
        tintColor       = UIColor.white
        
        for subview in self.subviews {
            for view in subview.subviews {
                if view.isKind(of: NSClassFromString("UISearchBarBackground")!) {
                    let imageView = view as! UIImageView
                    imageView.removeFromSuperview()
                }
            }
        }
        
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = ArkPalette.secondaryBackgroundColor
            textField.textColor       = ArkPalette.highlightedTextColor
            textField.borderStyle     = .roundedRect
            
            searchTextPositionAdjustment = UIOffsetMake(5.0, 0.0)
            
            if let placeholderLabel = textField.value(forKey: "placeholderLabel") as? UILabel {
                placeholderLabel.textColor = UIColor.white
            }
            
            if let clearButton = textField.value(forKey: "clearButton") as? UIButton {
                clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                clearButton.tintColor = UIColor.white
            }
        }
    }
}

extension String {
    
    func isNumeric() -> Bool {
        if let _ = range(of: "^[0-9]+$", options: .regularExpression) {
            return true
        }
        return false
    }
}

extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        
        let maskLayer = CALayer()
        maskLayer.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        maskLayer.backgroundColor = color.cgColor
        maskLayer.doMask(by: self)
        let maskImage = maskLayer.toImage()
        return maskImage
    }
}

extension CALayer {
    func doMask(by imageMask: UIImage) {
        let maskLayer = CAShapeLayer()
        maskLayer.bounds = CGRect(x: 0, y: 0, width: imageMask.size.width, height: imageMask.size.height)
        bounds = maskLayer.bounds
        maskLayer.contents = imageMask.cgImage
        maskLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        mask = maskLayer
    }
    
    func toImage() -> UIImage?
    {
        UIGraphicsBeginImageContextWithOptions(bounds.size,
                                               isOpaque,
                                               UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIButton {
    
    public func title(_ text: String, color: UIColor) {
        setTitle(text, for: .normal)
        setTitleColor(color, for: .normal)
    }
    
    public func setBackgroundColor(_ color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
}






