//
//  Account.swift
//  ArkMonitor
//
//  Created by Victor Lins on 23/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class Account: NSObject {
    public var address: String = ""
    public var publicKey : String = ""
    public var username: String = "-"
    public var balance : Int64 = 0

    public static func fromArrayJson(accountsJsonArray: NSArray) -> [Account] {
        var accounts : [Account] = []
        
        for accountJson in accountsJsonArray {
            accounts.append(Account.fromJson(objectJson: accountJson as! NSDictionary))
        }
        
        return accounts
    }
    
    public static func fromJson(objectJson : NSDictionary) -> Account {
        let account = Account()

        if let address = objectJson.object(forKey: "address") as? String {
            account.address = address
        }

        if let publicKey = objectJson.object(forKey: "publicKey") as? String {
            account.publicKey = publicKey
        }

        if let username = objectJson.object(forKey: "username") as? String {
            account.username = username
        }

        if let balance = objectJson.object(forKey: "balance") as? String {
            account.balance = Int64(balance)!
        }

        return account
    }
}
