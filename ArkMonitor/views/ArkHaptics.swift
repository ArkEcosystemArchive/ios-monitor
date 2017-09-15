//
//  ArkHaptics.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-15.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

struct ArkHaptics {
    
    static public func selectionChanged() {
        if #available(iOS 10, *) {
            let feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator.selectionChanged()
        }
    }
}
