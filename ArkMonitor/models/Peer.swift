//
//  Peer.swift
//  ArkMonitor
//
//  Created by Victor Lins on 23/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

enum PeerStatus: String {
    case banned = "EUNAVAILABLE"
    case disconnected = "ETIMEOUT"
    case connected = "OK"
    case undefined = "ERESPONSE"

    public static func fromState(state: String) -> PeerStatus {
        switch (state){
        case "EUNAVAILABLE":
            return banned
        case "ETIMEOUT":
            return disconnected
        case "OK":
            return connected
        default:
            return undefined
        }
    }
}

class Peer: NSObject {
    public var ip: String = ""
    public var port: NSInteger = 0
    public var status: String = ""
    public var os: String = ""
    public var version: String = ""
    
    public static func fromArrayJson(peersJsonArray: NSArray) -> [Peer] {
        var peers : [Peer] = []
        
        for peerJson in peersJsonArray {
            peers.append(Peer.fromJson(objectJson: peerJson as! NSDictionary))
        }
        
        return peers
    }
    
    public static func fromJson(objectJson : NSDictionary) -> Peer {
        let peer = Peer()
        
        if let ip = objectJson.object(forKey: "ip") as? String {
            peer.ip = ip
        }
        
        if let port = objectJson.object(forKey: "port") as? Int {
            peer.port = port
        }
        
        if let status = objectJson.object(forKey: "status") as? String {
            peer.status = status
        }
        
        if let os = objectJson.object(forKey: "os") as? String {
            peer.os = os
        }
        
        if let version = objectJson.object(forKey: "version") as? String {
            peer.version = version
        }

        return peer
    }
}
