//
//  Forging.swift
//  ArkMonitor
//
//  Created by Victor Lins on 23/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class Forging: NSObject {
    public var fees: Int64 = 0
    public var rewards: Int64 = 0
    public var forged: Int64 = 0
    
    public static func fromJson(objectJson : NSDictionary) -> Forging {
        let forging = Forging()
        
        if let fees = objectJson.object(forKey: "fees") as? String {
            forging.fees = Int64(fees)!
        }
        
        if let rewards = objectJson.object(forKey: "rewards") as? String {
            forging.rewards = Int64(rewards)!
        }
        
        if let forged = objectJson.object(forKey: "forged") as? String {
            forging.forged = Int64(forged)!
        }

        
        return forging
    }
}
