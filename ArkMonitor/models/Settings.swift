//
//  Settings.swift
//  ArkMonitor
//
//  Created by Victor Lins on 23/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

enum Server: Int {
    case arkNet1 = 0
    case arkNet2 = 1
    case custom = 2
    
    static var count: Int { return Server.custom.hashValue + 1 }
    
    var description: String {
        switch self {
        case .arkNet1 : return "node1.arknet.cloud"
        case .arkNet2 :  return "node2.arknet.cloud"
        case .custom : return "Custom"
        }
    }
    
    var apiUrl: String {
        switch self {
        case .arkNet1: return "https://node1.arknet.cloud/api/"
        case .arkNet2   : return "https://node2.arknet.cloud/api/"
        case .custom : return ""
        }
    }
}

class Settings: NSObject {
    public var username: String = "";
    public var arkAddress: String = "";
    public var publicKey: String = "";
    public var ipAddress: String = "";
    public var port: NSInteger = 0;
    public var sslEnabled: Bool = false
    public var serverType: Server = Server.arkNet1

    public static let usernameAttr = "settings.username"
    public static let arkAddressAttr = "settings.ark_address"
    public static let publicKeyAttr = "settings.public_key"
    public static let ipAddressAttr = "settings.ip_address"
    public static let portAttr = "settings.port"
    public static let sslEnabledAttr = "settings.ssl_enabled"
    public static let serverTypeAttr = "settings.server_type"
    public static let notificationIntervalAttr = "settings.notification_interval"

    public func setServerType(serverType: Server) {
        self.serverType = serverType
        if (serverType != Server.custom) {
            self.ipAddress = ""
            self.port = -1
            self.sslEnabled = true
        }
    }

    public func isCustomServer() -> Bool {
        return self.serverType == Server.custom
    }
    
    public func isValid() -> Bool {
        if (!Utils.validateUsername(username: username)) {
            return false
        }

        if (serverType.hashValue == Server.custom.hashValue) {
            if (!Utils.validateIpAddress(ipAddress: ipAddress)) {
                return false
            }

            if (!Utils.validatePort(port: port)) {
                return false
            }
        }

        return true
    }
    
    public static func saveSettings(settings: Settings) -> Void {
        let defaults = UserDefaults.standard
        defaults.set(settings.username, forKey: Settings.usernameAttr)
        defaults.set(settings.arkAddress, forKey: Settings.arkAddressAttr)
        defaults.set(settings.publicKey, forKey: Settings.publicKeyAttr)
        defaults.set(settings.ipAddress, forKey: Settings.ipAddressAttr)
        defaults.set(settings.port, forKey: Settings.portAttr)
        defaults.set(settings.sslEnabled, forKey: Settings.sslEnabledAttr)
        defaults.set(settings.serverType.hashValue, forKey: Settings.serverTypeAttr)
    }
    
    public static func getSettings() -> Settings {
        let settings = Settings()
        let defaults = UserDefaults.standard
        
        if let username = defaults.object(forKey: Settings.usernameAttr) as? String {
            settings.username = username
        }
        
        if let arkAddress = defaults.object(forKey: Settings.arkAddressAttr) as? String {
            settings.arkAddress = arkAddress
        }
        
        if let publicKey = defaults.object(forKey: Settings.publicKeyAttr) as? String {
            settings.publicKey = publicKey
        }
        
        if let ipAddress = defaults.object(forKey: Settings.ipAddressAttr) as? String {
            settings.ipAddress = ipAddress
        }
        
        if let port = defaults.object(forKey: Settings.portAttr) as? Int {
            settings.port = port
        }
        
        if let sslEnabled = defaults.object(forKey: Settings.sslEnabledAttr) as? Bool {
            settings.sslEnabled = sslEnabled
        }
        
        if let serverType = defaults.object(forKey: Settings.serverTypeAttr) as? Int {
            settings.serverType = Server(rawValue: serverType)!
        }

        return settings
    }

}
