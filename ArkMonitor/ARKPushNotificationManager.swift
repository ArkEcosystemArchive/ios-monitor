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
