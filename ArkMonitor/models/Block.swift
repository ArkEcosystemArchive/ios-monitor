//
//  Block.swift
//  ArkMonitor
//
//  Created by Victor Lins on 23/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class Block: NSObject {
    public var id: String = ""
    public var version: Int = 0
    public var timestamp: Int64 = 0
    public var height: Int64 = 0
    public var previousBlock: String = ""
    public var numberOfTransactions: Int64 = 0
    public var totalAmount: Int64 = 0
    public var totalFee: Int64 = 0
    public var reward: Int64 = 0
    public var payloadLength: Int64 = 0
    public var payloadHash: String = ""
    public var generatorPublicKey: String = ""
    public var generatorId: String = ""
    public var blockSignature: String = ""
    public var confirmations: Int64 = 0
    public var totalForged: Int64 = 0
    
    public static func fromArrayJson(blocksJsonArray: NSArray) -> [Block] {
        var blocks : [Block] = []
        
        for blockJson in blocksJsonArray {
            blocks.append(Block.fromJson(objectJson: blockJson as! NSDictionary))
        }
        
        return blocks
    }
    
    public static func fromJson(objectJson : NSDictionary) -> Block {
        let block = Block()
        
        if let id = objectJson.object(forKey: "id") as? String {
            block.id = id
        }
        
        if let version = objectJson.object(forKey: "version") as? Int {
            block.version = version
        }
        
        if let timestamp = objectJson.object(forKey: "timestamp") as? Int64 {
            block.timestamp = timestamp
        }
        
        if let height = objectJson.object(forKey: "height") as? Int64 {
            block.height = height
        }
        
        if let previousBlock = objectJson.object(forKey: "previousBlock") as? String {
            block.previousBlock = previousBlock
        }
        
        if let numberOfTransactions = objectJson.object(forKey: "numberOfTransactions") as? Int64 {
            block.numberOfTransactions = numberOfTransactions
        }
        
        if let totalAmount = objectJson.object(forKey: "totalAmount") as? Int64 {
            block.totalAmount = totalAmount
        }
        
        if let totalFee = objectJson.object(forKey: "totalFee") as? Int64 {
            block.totalFee = totalFee
        }
        
        if let reward = objectJson.object(forKey: "reward") as? Int64 {
            block.reward = reward
        }
        
        if let payloadLength = objectJson.object(forKey: "payloadLength") as? Int64 {
            block.payloadLength = payloadLength
        }
        
        if let payloadHash = objectJson.object(forKey: "payloadLength") as? String {
            block.payloadHash = payloadHash
        }
        
        if let generatorPublicKey = objectJson.object(forKey: "generatorPublicKey") as? String {
            block.generatorPublicKey = generatorPublicKey
        }
        
        if let generatorId = objectJson.object(forKey: "generatorId") as? String {
            block.generatorId = generatorId
        }
        
        if let blockSignature = objectJson.object(forKey: "blockSignature") as? String {
            block.blockSignature = blockSignature
        }
        
        if let confirmations = objectJson.object(forKey: "confirmations") as? Int64 {
            block.confirmations = confirmations
        }
        
        if let totalForged = objectJson.object(forKey: "totalForged") as? Int64 {
            block.totalForged = totalForged
        }

        return block
    }
}

