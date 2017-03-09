//
//  Transaction.swift
//  ArkMonitor
//
//  Created by Victor Lins on 23/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class Transaction: NSObject {
    public var id: String = ""
    public var type: Int = 0
    public var timestamp: Int = 0
    public var senderPublicKey: String = ""
    public var senderId: String = ""
    public var recipientId: String = ""
    public var amount: Int64 = 0
    public var fee: Int = 0
    public var signature: String = ""
    public var confirmations: Int = 0
    
    public static func fromArrayJson(transactionsJsonArray: NSArray) -> [Transaction] {
        var transactions : [Transaction] = []
        
        for transactionJson in transactionsJsonArray {
            transactions.append(Transaction.fromJson(objectJson: transactionJson as! NSDictionary))
        }
        
        return transactions
    }
    
    public static func fromJson(objectJson : NSDictionary) -> Transaction {
        let transaction = Transaction()
        
        if let id = objectJson.object(forKey: "id") as? String {
            transaction.id = id
        }
        
        if let type = objectJson.object(forKey: "type") as? Int {
            transaction.type = type
        }
        
        if let timestamp = objectJson.object(forKey: "timestamp") as? Int {
            transaction.timestamp = timestamp
        }
        
        if let senderPublicKey = objectJson.object(forKey: "senderPublicKey") as? String {
            transaction.senderPublicKey = senderPublicKey
        }
        
        if let senderId = objectJson.object(forKey: "senderId") as? String {
            transaction.senderId = senderId
        }
        
        if let recipientId = objectJson.object(forKey: "recipientId") as? String {
            transaction.recipientId = recipientId
        }
        
        if let amount = objectJson.object(forKey: "amount") as? Int64 {
            transaction.amount = amount
        }
        
        if let fee = objectJson.object(forKey: "fee") as? Int {
            transaction.fee = fee
        }
        
        if let signature = objectJson.object(forKey: "signature") as? String {
            transaction.signature = signature
        }
        
        if let confirmations = objectJson.object(forKey: "confirmations") as? Int {
            transaction.confirmations = confirmations
        }
        
        return transaction
    }
}
