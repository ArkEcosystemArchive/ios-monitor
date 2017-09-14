//
//  UINavigationBar+Extension.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-13.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    public var bottomBorderColor: UIColor {
        get {
            return self.bottomBorderColor;
        }
        set {
            let bottomBorderRect = CGRect.zero;
            let bottomBorderView = UIView(frame: bottomBorderRect);
            bottomBorderView.backgroundColor = newValue;
            addSubview(bottomBorderView);
            
            bottomBorderView.translatesAutoresizingMaskIntoConstraints = false;
            
            self.addConstraint(NSLayoutConstraint(item: bottomBorderView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0));
            self.addConstraint(NSLayoutConstraint(item: bottomBorderView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0));
            self.addConstraint(NSLayoutConstraint(item: bottomBorderView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0));
            self.addConstraint(NSLayoutConstraint(item: bottomBorderView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 1));
        }
    }
}
