//
//  Server.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-14.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

struct CustomServer {
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
}
