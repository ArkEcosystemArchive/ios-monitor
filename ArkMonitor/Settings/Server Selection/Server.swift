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
