//
//  Delegate.swift
//  ArkMonitor
//
//  Created by Victor Lins on 23/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class Delegate: NSObject {
    public var username: String = ""
    public var address: String = ""
    public var publicKey: String = ""
    public var vote: String = ""
    public var producedblocks: Int64 = 0
    public var missedblocks: Int64 = 0
    public var rate: Int64 = 0
    public var productivity: Double = 0.0
    public var approval: Double = 0.0

    public static func fromArrayJson(delegatesJsonArray: NSArray) -> [Delegate] {
        var delegates : [Delegate] = []
        
        for delegateJson in delegatesJsonArray {
            delegates.append(Delegate.fromJson(objectJson: delegateJson as! NSDictionary))
        }
        
       return delegates
    }

    public static func fromJson(objectJson : NSDictionary) -> Delegate {
        let delegate = Delegate()
        
        
        if let username = objectJson.object(forKey: "username") as? String {
            delegate.username = username
        }
        
        if let address = objectJson.object(forKey: "address") as? String {
            delegate.address = address
        }
        
        if let publicKey = objectJson.object(forKey: "publicKey") as? String {
            delegate.publicKey = publicKey
        }
        
        if let vote = objectJson.object(forKey: "vote") as? String {
            delegate.vote = vote
        }
        
        if let producedblocks = objectJson.object(forKey: "producedblocks") as? Int64 {
            delegate.producedblocks = producedblocks
        }
        
        if let missedblocks = objectJson.object(forKey: "missedblocks") as? Int64 {
            delegate.missedblocks = missedblocks
        }
        
        if let rate = objectJson.object(forKey: "rate") as? Int64 {
            delegate.rate = rate
        }
        
        if let productivity = objectJson.object(forKey: "productivity") as? Double {
            delegate.productivity = productivity
        }

        if let approval = objectJson.object(forKey: "approval") as? Double {
            delegate.approval = approval
        }

        return delegate
    }
}
