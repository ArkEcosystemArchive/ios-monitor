//
//  Server.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-14.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit
import SwiftyArk

public struct CustomServer: Equatable {
    
    static public func ==(lhs: CustomServer, rhs: CustomServer) -> Bool {
        return lhs.name == rhs.name
    }
    
    let name      : String
    let ipAddress : String
    let port      : Int
    let isSSL     : Bool
    
    init(_ name: String, ipAddress: String, port: Int, isSSL: Bool) {
        self.name      = name
        self.ipAddress = ipAddress
        self.port      = port
        self.isSSL     = isSSL
    }
    
    init?(dictionary: [String : AnyObject]) {
        
        guard let name     = dictionary["name"]   as? String,
             let ipAddress = dictionary["ipAdress"] as? String,
             let port      = dictionary["port"]     as? Int,
             let isSSL     = dictionary["isSSL"]    as? Bool
        else {
            print("Failed to Create CustomServer")
            return nil
        }
        self.name      = name
        self.ipAddress = ipAddress
        self.port      = port
        self.isSSL     = isSSL
    }
        
    public func dictionary() -> [String : AnyObject] {
        return ["name": name as AnyObject, "ipAdress": ipAddress as AnyObject, "port": port as AnyObject, "isSSL": isSSL as AnyObject]
    }
    
    public func network() -> Network {
        return Network(ipAddress, port: port, isSSL: isSSL)
    }
}
