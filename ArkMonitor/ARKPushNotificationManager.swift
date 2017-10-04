//
//  ARKPushNotificationManager.swift
//  Dark
//
//  Created by Andrew on 2017-09-25.
//  Copyright © 2017 Walzy. All rights reserved.
//

import Foundation
import SwiftyArk
import UserNotifications


struct ArkPushNotificationManager {
    
    static public func updateDelegateForgingStatus(_ delegate: Delegate) {
        let title = "Delegate Update"
        var body : String!
        if delegate.isForging == true {
            body = "Your delegate \(delegate.username) has been voted into the top 51 delegates (position \(delegate.rate))"
        } else {
            body = "Your delegate \(delegate.username) has been voted out of the top 51 delegates (position \(delegate.rate))"
        }
        
        postNotification(title, body: body)
    }
    
    static public func newTransactionNotification(_ transaction: Transaction) {
        let title = "Transaction"
        var body : String!

        switch transaction.status() {
        case .received:
            body = "You received a new transaction for \(transaction.amount) Ark"
        default:
            return
        }
        postNotification(title, body: body)
    }
    
    static private func postNotification(_ title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: nil)
        
        let center = UNUserNotificationCenter.current()
        
        center.add(request) { (error) in
            if let aError = error {
                print(aError)
            }
        }
    }
}
