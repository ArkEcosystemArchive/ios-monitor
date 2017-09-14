//
//  ArkCustomServerManager.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-14.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

struct ArkCustomServerManager {
    
    static public private(set) var CurrentCustomServer: CustomServer? {
        get {
            guard let rawData = UserDefaults.standard.object(forKey: "currentCustomServer") as? [String: AnyObject] else {
                return nil
            }
            
            if let server = CustomServer(dictionary: rawData) {
                return server
            } else {
                return nil
            }
        }
        set {
            if let server = newValue {
                UserDefaults.standard.set(server.dictionary(), forKey: "currentCustomServer")
            } else {
                UserDefaults.standard.removeObject(forKey: "currentCustomServer")
            }
            UserDefaults.standard.synchronize()
        }
    }
    
    static public private(set) var CustomServers: [CustomServer] {
        get {
            guard let rawData = UserDefaults.standard.object(forKey: "customServers") as? [[String: AnyObject]] else {
                return []
            }
            
            var servers = [CustomServer]()
            
            for data in rawData {
                if let server = CustomServer(dictionary: data) {
                    servers.append(server)
                }
            }
            return servers
        }
        set {
            let newServers = newValue
            
            var newDict = [[String: AnyObject]]()
            
            for server in newServers {
                newDict.append(server.dictionary())
            }
            
            UserDefaults.standard.set(newDict, forKey: "customServers")
            UserDefaults.standard.synchronize()
        }
    }
    
    static public func add(_ newServer: CustomServer, success: @escaping(_ success: Bool) -> ()) {
        var currentServers = CustomServers
        for server in CustomServers {
            if server == newServer {
                success(false)
                return
            }
        }
        
        currentServers.append(newServer)
        CustomServers = currentServers
        success(true)
    }
    
    static public func remove(_ server: CustomServer) {
        var currentServers = CustomServers
        
        for aServer in currentServers {
            if server == aServer {
                currentServers.remove(object: aServer)
            }
        }
        CustomServers = currentServers
    }
}

extension Array where Element: Equatable {
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
