//
//  Utils.swift
//  ArkMonitor
//
//  Created by Victor Lins on 23/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    
    private static let IpAddressFormat = "^(([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\.){3}([01]?\\d\\d?|2[0-4]\\d|25[0-5])$"
    private static let maxPortNumber = 65535
    private static let startDate = "24/05/2016 17:00:00"
    private static let formatDate = "dd/MM/yyyy HH:mm:ss"
    private static let timeZone = "UTC"
    
    public static func validateArkAddress(arkAddress: String) -> Bool {
        return arkAddress.length > 0
    }

    public static func validateIpAddress(ipAddress: String) -> Bool {
        let IpAddressPredicate = NSPredicate(format:"SELF MATCHES %@", Utils.IpAddressFormat)
        return IpAddressPredicate.evaluate(with: ipAddress)
    }

    public static func validatePort(port: NSInteger) -> Bool {
        return port > 0 && port <= maxPortNumber
    }

    public static func validatePortStr(portStr: String) -> Bool {
        if let port = Int(portStr) {
            return validatePort(port: port)
        }
        return false
    }
    
    public static func validatePublicKey(publicKey: String) -> Bool {
        return publicKey.length > 0
    }

    public static func validateUsername(username: String) -> Bool {
        return username.length > 0 && username.length <= 20
    }

    public static func convertToArkBase(value: Int64) -> Double {
        return Double(value) * pow(10, -8)
    }

    public static func getTimeAgo(timestamp : Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let startDate = dateFormatter.date(from: "24/05/2016 17:00:00")
        
        let diffStartTimes = startDate?.timeIntervalSince1970

        let date = Date(timeIntervalSince1970: timestamp + diffStartTimes!)

        return Utils.timeAgoSince(date)
    }

    private static func timeAgoSince(_ date: Date) -> String {
        
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
        
        if let year = components.year, year >= 2 {
            return "\(year) years ago"
        }
        
        if let year = components.year, year >= 1 {
            return "Last year"
        }
        
        if let month = components.month, month >= 2 {
            return "\(month) months ago"
        }
        
        if let month = components.month, month >= 1 {
            return "Last month"
        }
        
        if let week = components.weekOfYear, week >= 2 {
            return "\(week) weeks ago"
        }
        
        if let week = components.weekOfYear, week >= 1 {
            return "Last week"
        }
        
        if let day = components.day, day >= 2 {
            return "\(day) days ago"
        }
        
        if let day = components.day, day >= 1 {
            return "Yesterday"
        }
        
        if let hour = components.hour, hour >= 2 {
            return "\(hour) hours ago"
        }
        
        if let hour = components.hour, hour >= 1 {
            return "An hour ago"
        }
        
        if let minute = components.minute, minute >= 2 {
            return "\(minute) minutes ago"
        }
        
        if let minute = components.minute, minute >= 1 {
            return "A minute ago"
        }
        
        if let second = components.second, second >= 3 {
            return "\(second) seconds ago"
        }
        
        return "Just now"
        
    }
}
