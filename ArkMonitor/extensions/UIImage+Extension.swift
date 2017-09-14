//
//  UIImage+Extension.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-13.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit
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
