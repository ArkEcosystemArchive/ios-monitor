//
//  ArkNotificationManager.swift
//  Dark
//
//  Created by Andrew on 2017-09-21.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation

enum ArkNotifications: String {
    case accountUpdated      = "homeUpdated"
    case transactionsUpdated = "transactionsUpdated"
    case tickerUpdated       = "tickerUpdated"
    case delegateListUpdated = "delegateListUpdated"
    case accountVoteUpdated  = "accountVoteUpdated"
    case accountLogout       = "accountLogout"
}

class ArkNotificationManager: NSObject {
    static func postNotification(_ notification: ArkNotifications) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: notification.rawValue), object: nil, userInfo: nil)
    }
}

