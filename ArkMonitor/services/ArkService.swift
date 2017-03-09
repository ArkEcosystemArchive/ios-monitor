//
//  ArkService.swift
//  ArkMonitor
//
//  Created by Victor Lins on 23/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import Alamofire

class ArkService: NSObject {
    
    private static let ipAttr = "ip"
    private static let portAttr = "port"
    private static let customApiUrl = ipAttr + ":" + portAttr + "/api/"

    private static let delegatesUrl = customApiUrl + "delegates/"
    private static let activePeersUrl = customApiUrl + "peers"
    private static let votesUrl = customApiUrl + "accounts/delegates/"
    private static let accountUrl = customApiUrl + "accounts/"
    private static let votersUrl = customApiUrl + "delegates/voters"
    private static let forgingUrl = customApiUrl + "delegates/forging/getForgedByAccount"
    private static let statusUrl = customApiUrl + "loader/status/sync"
    private static let peerVersionUrl = customApiUrl + "peers/version"
    private static let delegateUrl = customApiUrl + "delegates/get"
    private static let blocksUrl = customApiUrl + "blocks"
    private static let transactionsUrl = customApiUrl + "transactions"
    
    private static let httpProtocol = "http://"
    private static let httpsProtocol = "https://"
    
    static let sharedInstance : ArkService = {
        let instance = ArkService()
        return instance
    }()
    
    override init() {
        
    }
    
    public func requestActiveDelegates(settings: Settings,
                                       listener : RequestListener) -> Void {
        self.requestDelegates(settings: settings, offset: 0, listener: listener)
    }
    
    public func requestStandyByDelegates(settings: Settings,
                                         listener : RequestListener) -> Void {
        self.requestDelegates(settings: settings, offset: 51, listener: listener)
    }
    
    private func requestDelegates(settings: Settings,
                                  offset: Int,
                                  listener : RequestListener) -> Void {
        
        if (settings.isCustomServer()) {
            if (!Utils.validateIpAddress(ipAddress: settings.ipAddress)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid IP Address"
                    ])
                
                listener.onFailure(e: error)
                
                return
            }
            
            if (!Utils.validatePort(port: settings.port)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid Port"
                    ])
                
                listener.onFailure(e: error)
                return
            }
        }
        
        var urlRequest = ArkService.delegatesUrl + "?limit=51&offset=" + String(offset) + "&orderBy=rate:asc"
        
        urlRequest = self.replaceURLWithSettings(url: urlRequest, settings: settings)
        
        Alamofire.request(urlRequest).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                
                let success = response.object(forKey: "success")! as! Bool
                
                var delegates : [Delegate] = []
                
                if (success) {
                    let delegateJsonArray = response.object(forKey: "delegates")! as! NSArray
                    delegates.append(contentsOf: Delegate.fromArrayJson(delegatesJsonArray: delegateJsonArray))
                }
                
                listener.onResponse(object: delegates)
                
            case .failure(let error):
                listener.onFailure(e: error)
            }
        }
        
    }
    
    public func requestPeers(settings: Settings,
                             listener : RequestListener) -> Void {
        if (settings.isCustomServer()) {
            if (!Utils.validateIpAddress(ipAddress: settings.ipAddress)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid IP Address"
                    ])
                
                listener.onFailure(e: error)
                
                return
            }
            
            if (!Utils.validatePort(port: settings.port)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid Port"
                    ])
                
                listener.onFailure(e: error)
                return
            }
        }
        
        let urlRequest = self.replaceURLWithSettings(url: ArkService.activePeersUrl, settings: settings)
        
        Alamofire.request(urlRequest).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                
                let success = response.object(forKey: "success")! as! Bool
                
                var peers : [Peer] = []
                
                if (success) {
                    let peersJsonArray = response.object(forKey: "peers")! as! NSArray
                    peers.append(contentsOf: Peer.fromArrayJson(peersJsonArray: peersJsonArray))
                }
                
                listener.onResponse(object: peers)
                
            case .failure(let error):
                listener.onFailure(e: error)
            }
        }
    }
    
    public func requestAccount(settings: Settings,
                               listener : RequestListener) -> Void {
        if (settings.isCustomServer()) {
            if (!Utils.validateIpAddress(ipAddress: settings.ipAddress)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid IP Address"
                    ])
                
                listener.onFailure(e: error)
                
                return
            }
            
            if (!Utils.validatePort(port: settings.port)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid Port"
                    ])
                
                listener.onFailure(e: error)
                return
            }
        }
        
        if (!Utils.validateArkAddress(arkAddress: settings.arkAddress)) {
            let error = NSError(domain: "", code: -1, userInfo: [
                NSLocalizedDescriptionKey: "Invalid Ark Address"
                ])
            
            listener.onFailure(e: error)
            
            return
        }
        
        var urlRequest = self.replaceURLWithSettings(url: ArkService.accountUrl, settings: settings)
        urlRequest = urlRequest + "?address=" + settings.arkAddress
        
        Alamofire.request(urlRequest).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                
                let success = response.object(forKey: "success")! as! Bool
                
                if (success) {
                    let accountJson = response.object(forKey: "account")! as! NSDictionary
                    listener.onResponse(object: Account.fromJson(objectJson: accountJson))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [
                        NSLocalizedDescriptionKey: "Invalid Account"
                        ])
                    
                    listener.onFailure(e: error)
                }
                
            case .failure(let error):
                listener.onFailure(e: error)
            }
        }
    }
    
    public func requestVotes(settings: Settings,
                             listener : RequestListener) -> Void {
        if (settings.isCustomServer()) {
            if (!Utils.validateIpAddress(ipAddress: settings.ipAddress)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid IP Address"
                    ])
                
                listener.onFailure(e: error)
                
                return
            }
            
            if (!Utils.validatePort(port: settings.port)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid Port"
                    ])
                
                listener.onFailure(e: error)
                return
            }
        }
        
        if (!Utils.validateArkAddress(arkAddress: settings.arkAddress)) {
            let error = NSError(domain: "", code: -1, userInfo: [
                NSLocalizedDescriptionKey: "Invalid Ark Address"
                ])
            
            listener.onFailure(e: error)
            
            return
        }
        
        var urlRequest = self.replaceURLWithSettings(url: ArkService.votesUrl, settings: settings)
        urlRequest = urlRequest + "?address=" + settings.arkAddress
        
        Alamofire.request(urlRequest).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                
                let success = response.object(forKey: "success")! as! Bool
                
                let votes = Votes()
                var delegates : [Delegate] = []
                
                if (success) {
                    let delegateJsonArray = response.object(forKey: "delegates")! as! NSArray
                    delegates.append(contentsOf: Delegate.fromArrayJson(delegatesJsonArray: delegateJsonArray))
                }
                
                votes.delegates = delegates
                
                listener.onResponse(object: votes)
                
            case .failure(let error):
                listener.onFailure(e: error)
            }
        }
    }
    
    public func requestVoters(settings: Settings,
                              listener : RequestListener) -> Void {
        if (settings.isCustomServer()) {
            if (!Utils.validateIpAddress(ipAddress: settings.ipAddress)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid IP Address"
                    ])
                
                listener.onFailure(e: error)
                
                return
            }
            
            if (!Utils.validatePort(port: settings.port)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid Port"
                    ])
                
                listener.onFailure(e: error)
                return
            }
        }
        
        if (!Utils.validatePublicKey(publicKey: settings.publicKey)) {
            let error = NSError(domain: "", code: -1, userInfo: [
                NSLocalizedDescriptionKey: "Invalid publicKey"
                ])
            
            listener.onFailure(e: error)
            
            return
        }
        
        var urlRequest = self.replaceURLWithSettings(url: ArkService.votersUrl, settings: settings)
        urlRequest = urlRequest + "?publicKey=" + settings.publicKey
        
        Alamofire.request(urlRequest).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                
                let success = response.object(forKey: "success")! as! Bool
                
                let voters = Voters()
                var accounts : [Account] = []
                
                if (success) {
                    let accountJsonArray = response.object(forKey: "accounts")! as! NSArray
                    accounts.append(contentsOf: Account.fromArrayJson(accountsJsonArray: accountJsonArray))
                }
                
                voters.accounts = accounts
                
                listener.onResponse(object: voters)
                
            case .failure(let error):
                listener.onFailure(e: error)
            }
        }
    }
    
    public func requestPeerVersion(settings: Settings,
                                   listener : RequestListener) -> Void {
        if (settings.isCustomServer()) {
            if (!Utils.validateIpAddress(ipAddress: settings.ipAddress)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid IP Address"
                    ])
                
                listener.onFailure(e: error)
                
                return
            }
            
            if (!Utils.validatePort(port: settings.port)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid Port"
                    ])
                
                listener.onFailure(e: error)
                return
            }
        }
        
        let urlRequest = self.replaceURLWithSettings(url: ArkService.peerVersionUrl, settings: settings)
        
        Alamofire.request(urlRequest).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                
                listener.onResponse(object: PeerVersion.fromJson(objectJson: response))
                
            case .failure(let error):
                listener.onFailure(e: error)
            }
        }
    }
    
    public func requestStatus(settings: Settings,
                              listener : RequestListener) -> Void {
        if (settings.isCustomServer()) {
            if (!Utils.validateIpAddress(ipAddress: settings.ipAddress)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid IP Address"
                    ])
                
                listener.onFailure(e: error)
                
                return
            }
            
            if (!Utils.validatePort(port: settings.port)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid Port"
                    ])
                
                listener.onFailure(e: error)
                return
            }
        }
        
        let urlRequest = self.replaceURLWithSettings(url: ArkService.statusUrl, settings: settings)
        
        Alamofire.request(urlRequest).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                
                listener.onResponse(object: Status.fromJson(objectJson: response))
                
            case .failure(let error):
                listener.onFailure(e: error)
            }
        }
    }
    
    public func requestForging(settings: Settings,
                               listener : RequestListener) -> Void {
        if (settings.isCustomServer()) {
            if (!Utils.validateIpAddress(ipAddress: settings.ipAddress)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid IP Address"
                    ])
                
                listener.onFailure(e: error)
                
                return
            }
            
            if (!Utils.validatePort(port: settings.port)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid Port"
                    ])
                
                listener.onFailure(e: error)
                return
            }
        }
        
        if (!Utils.validatePublicKey(publicKey: settings.publicKey)) {
            let error = NSError(domain: "", code: -1, userInfo: [
                NSLocalizedDescriptionKey: "Invalid publicKey"
                ])
            
            listener.onFailure(e: error)
            
            return
        }
        
        var urlRequest = self.replaceURLWithSettings(url: ArkService.forgingUrl, settings: settings)
        urlRequest = urlRequest + "?generatorPublicKey=" + settings.publicKey
        
        Alamofire.request(urlRequest).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                
                listener.onResponse(object: Forging.fromJson(objectJson: response))
                
            case .failure(let error):
                listener.onFailure(e: error)
            }
        }
    }
    
    
    public func requestDelegate(settings: Settings,
                                listener : RequestListener) -> Void {
        if (settings.isCustomServer()) {
            if (!Utils.validateIpAddress(ipAddress: settings.ipAddress)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid IP Address"
                    ])
                
                listener.onFailure(e: error)
                
                return
            }
            
            if (!Utils.validatePort(port: settings.port)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid Port"
                    ])
                
                listener.onFailure(e: error)
                return
            }
        }
        
        if (!Utils.validateUsername(username: settings.username)) {
            let error = NSError(domain: "", code: -1, userInfo: [
                NSLocalizedDescriptionKey: "Invalid username"
                ])
            
            listener.onFailure(e: error)
            
            return
        }
        
        var urlRequest = self.replaceURLWithSettings(url: ArkService.delegateUrl, settings: settings)
        urlRequest = urlRequest + "?username=" + settings.username
        
        Alamofire.request(urlRequest).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                
                let success = response.object(forKey: "success")! as! Bool
                
                if (success) {
                    let delegateJson = response.object(forKey: "delegate")! as! NSDictionary
                    
                    
                    listener.onResponse(object: Delegate.fromJson(objectJson: delegateJson))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [
                        NSLocalizedDescriptionKey: "Invalid delegate"
                        ])
                    
                    listener.onFailure(e: error)
                }

                
            case .failure(let error):
                listener.onFailure(e: error)
            }
        }
    }
    
    public func requestLastBlockForged(settings: Settings,
                                       listener : RequestListener) -> Void {
        if (settings.isCustomServer()) {
            if (!Utils.validateIpAddress(ipAddress: settings.ipAddress)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid IP Address"
                    ])
                
                listener.onFailure(e: error)
                
                return
            }
            
            if (!Utils.validatePort(port: settings.port)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid Port"
                    ])
                
                listener.onFailure(e: error)
                return
            }
        }
        
        if (!Utils.validatePublicKey(publicKey: settings.publicKey)) {
            let error = NSError(domain: "", code: -1, userInfo: [
                NSLocalizedDescriptionKey: "Invalid publicKey"
                ])
            
            listener.onFailure(e: error)
            
            return
        }
        
        var urlRequest = self.replaceURLWithSettings(url: ArkService.blocksUrl, settings: settings)
        urlRequest = urlRequest + "?generatorPublicKey=" + settings.publicKey + "&limit=1&offset=0&orderBy=height:desc"
        
        Alamofire.request(urlRequest).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                
                let success = response.object(forKey: "success")! as! Bool
                
                if (success) {
                    let blocksJsonArray = response.object(forKey: "blocks")! as! NSArray
                    
                    if (blocksJsonArray.count > 0) {
                        let blockJson = Block.fromJson(objectJson: blocksJsonArray[blocksJsonArray.count - 1] as! NSDictionary)
                        listener.onResponse(object: blockJson)
                    } else {
                        listener.onResponse(object: Block())
                    }
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [
                        NSLocalizedDescriptionKey: "Invalid block"
                        ])
                    
                    listener.onFailure(e: error)
                }
                
            case .failure(let error):
                listener.onFailure(e: error)
            }
        }
    }
    
    public func requestBlocks(settings: Settings,
                              listener: RequestListener) -> Void {
        if (settings.isCustomServer()) {
            if (!Utils.validateIpAddress(ipAddress: settings.ipAddress)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid IP Address"
                    ])
                
                listener.onFailure(e: error)
                
                return
            }
            
            if (!Utils.validatePort(port: settings.port)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid Port"
                    ])
                
                listener.onFailure(e: error)
                return
            }
        }
        
        if (!Utils.validatePublicKey(publicKey: settings.publicKey)) {
            let error = NSError(domain: "", code: -1, userInfo: [
                NSLocalizedDescriptionKey: "Invalid publicKey"
                ])
            
            listener.onFailure(e: error)
            
            return
        }
        
        var urlRequest = self.replaceURLWithSettings(url: ArkService.blocksUrl, settings: settings)
        urlRequest = urlRequest + "?generatorPublicKey=" + settings.publicKey + "&limit=100&offset=0&orderBy=height:desc"
        
        Alamofire.request(urlRequest).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                
                let success = response.object(forKey: "success")! as! Bool
                
                var blocks : [Block] = []
                
                if (success) {
                    let blocksJsonArray = response.object(forKey: "blocks")! as! NSArray
                    
                    blocks = Block.fromArrayJson(blocksJsonArray: blocksJsonArray)
                }
                
                listener.onResponse(object: blocks)
                
            case .failure(let error):
                listener.onFailure(e: error)
            }
        }
    }
    
    public func requestLatestTransactions(settings: Settings,
                                          listener : RequestListener) -> Void {
        if (settings.isCustomServer()) {
            if (!Utils.validateIpAddress(ipAddress: settings.ipAddress)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid IP Address"
                    ])
                
                listener.onFailure(e: error)
                
                return
            }
            
            if (!Utils.validatePort(port: settings.port)) {
                
                let error = NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Invalid Port"
                    ])
                
                listener.onFailure(e: error)
                return
            }
        }
        
        if (!Utils.validateArkAddress(arkAddress: settings.arkAddress)) {
            let error = NSError(domain: "", code: -1, userInfo: [
                NSLocalizedDescriptionKey: "Invalid Ip Address"
                ])
            
            listener.onFailure(e: error)
            
            return
        }
        
        var urlRequest = self.replaceURLWithSettings(url: ArkService.transactionsUrl, settings: settings)
        urlRequest = urlRequest + "?senderId=" + settings.arkAddress +
            "&recipientId=" + settings.arkAddress +
        "&orderBy=timestamp:desc&limit=10"
        
        Alamofire.request(urlRequest).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                
                let success = response.object(forKey: "success")! as! Bool
                
                var transactions : [Transaction] = []
                
                if (success) {
                    let transactionsJsonArray = response.object(forKey: "transactions")! as! NSArray
                    
                    transactions = Transaction.fromArrayJson(transactionsJsonArray: transactionsJsonArray)
                }
                
                listener.onResponse(object: transactions)
                
            case .failure(let error):
                listener.onFailure(e: error)
            }
        }
    }
    
    func replaceURLWithSettings(url: String, settings: Settings) -> String {
        if (!settings.isCustomServer()) {
            let apiUrl : String = url.replacingOccurrences(of: ArkService.customApiUrl, with: "")
            return settings.serverType.apiUrl + apiUrl
        }
        
        var apiUrl = url.replacingOccurrences(of:ArkService.ipAttr,
                                              with:settings.ipAddress)
        
        apiUrl = apiUrl.replacingOccurrences(of:ArkService.portAttr,
                                             with: String(settings.port))
        return (settings.sslEnabled ?
            ArkService.httpsProtocol : ArkService.httpProtocol) + apiUrl
    }
}
