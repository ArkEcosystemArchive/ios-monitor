//
//  ArkNotificationManager.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

enum ArkNotifications: String {
    case homeUpdated         = "homeUpdated"
    case forgedBlocksUpdated = "forgedBlocksUpdated"
    case transactionsUpdated = "transactionsUpdated"
    case delegatesUpdated    = "delegatesUpdated"
    case miscUpdated         = "miscUpdated"
}

class ArkNotificationManager: NSObject {
    static func postNotification(_ notification: ArkNotifications) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: notification.rawValue), object: nil, userInfo: nil)
    }
}
