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

import Foundation
import SwiftyArk

public struct ArkNetworkManager {
    
    static var currentNetwork: NetworkPreset? {
        get {
            if let presetString = UserDefaults.standard.string(forKey: "networkPreset") {
                if let preset = NetworkPreset(rawValue: presetString) {
                    return preset
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
        set {
            if let value = newValue {
                UserDefaults.standard.set(value.rawValue, forKey: "networkPreset")
                UserDefaults.standard.synchronize()
            } else {
                UserDefaults.standard.removeObject(forKey: "networkPreset")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    static public var CurrentCustomServer: CustomServer? {
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
    
    static public func updateNetwork(_ preset: NetworkPreset) {
        currentNetwork = preset
        CurrentCustomServer = nil
        ArkDataManager.startupOperations()
        ArkActivityView.showMessage("Successfully updated server", style: .success)
    }
    
    static public func updateNetwork(_ server: CustomServer) {
        CurrentCustomServer = server
        currentNetwork = nil
        ArkDataManager.startupOperations()
        ArkActivityView.showMessage("Successfully updated server", style: .success)
    }
    
    static public func setNetwork(_ manager: ArkManager) {
        if let customServer = CurrentCustomServer {
            manager.updateNetwork(customServer.network())
        } else if let serverPreset = currentNetwork {
            manager.updateNetworkPreset(serverPreset)
        } else {
            manager.updateNetworkPreset(.arknode)
            currentNetwork = .arknode
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
