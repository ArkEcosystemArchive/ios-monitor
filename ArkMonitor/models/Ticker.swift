//
//  Ticker.swift
//  ArkMonitor
//
//  Created by Victor Lins on 23/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class Ticker: NSObject {
    public var last: Double = 0
    public var lowestAsk: Double = 0
    public var highestBid: Double = 0
    public var percentChange: Double = 0
    public var baseVolume: Double = 0
    public var quoteVolume: Double = 0
    public var high24hr: Double = 0
    public var low24hr: Double = 0
    
    public static func fromJson(objectJson : NSDictionary) -> Ticker {
        let ticker = Ticker()
        
        if let last = objectJson.object(forKey: "last") as? String {
            ticker.last = Double(last)!
        }
        
        if let lowestAsk = objectJson.object(forKey: "lowestAsk") as? String {
            ticker.lowestAsk = Double(lowestAsk)!
        }
        
        if let highestBid = objectJson.object(forKey: "highestBid") as? String {
            ticker.highestBid = Double(highestBid)!
        }
        
        if let percentChange = objectJson.object(forKey: "percentChange") as? String {
            ticker.percentChange = Double(percentChange)!
        }
        
        if let baseVolume = objectJson.object(forKey: "baseVolume") as? String {
            ticker.baseVolume = Double(baseVolume)!
        }
        
        if let quoteVolume = objectJson.object(forKey: "quoteVolume") as? String {
            ticker.quoteVolume = Double(quoteVolume)!
        }
        
        if let high24hr = objectJson.object(forKey: "high24hr") as? String {
            ticker.high24hr = Double(high24hr)!
        }
        
        if let low24hr = objectJson.object(forKey: "low24hr") as? String {
            ticker.low24hr = Double(low24hr)!
        }
        
        return ticker
    }
}
