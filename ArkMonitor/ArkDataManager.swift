//
//  ArkDataManager.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

public struct ArkDataManager {
    
    static public let shared = ArkDataManager()
    
    static private var errorMessageDate : Date?
    static private var noNetworkDate    : Date?
    
    public struct Home {
        static var account         : Account     = Account()
        static var delegate        : Delegate    = Delegate()
        static var forging         : Forging     = Forging()
        static var status          : Status      = Status()
        static var peerVersion     : PeerVersion = PeerVersion()
        static var block           : Block       = Block()
        static var balance         : Double?
        static var arkBTCValue     : Double?
        static var bitcoinUSDValue : Double?
        static var bitcoinEURValue : Double?
    }
    
    public struct ForgedBlocks {
        static var blocks : [Block] = []
    }
    
    public struct Transactions {
        static var transactions : [Transaction] = []
    }
    
    public struct Delegates {
        static var delegates        : [Delegate] = []
        static var standByDelegates : [Delegate] = []
    }
    
    public struct Misc {
        static var peers  : [Peer]     = []
        static var votes  : [Delegate] = []
        static var voters : [Account]  = []
    }

    public func updateData() {
        updateHomeInfo()
        updateForgedBlocks()
        updateLatestTransactions()
        updateDelegates()
        updateMisc()
    }
    
     static fileprivate func handleError() {
        if let logDate = errorMessageDate {
            let now = Date()
            if now.timeIntervalSince(logDate) > 15 {
                ArkActivityView.showMessage("Cannot fetch data. Please verify settings.")
                errorMessageDate = now
            } else {
                return
            }
        } else {
            let now = Date()
            ArkActivityView.showMessage("Cannot fetch data. Please verify settings.")
            errorMessageDate = now
        }
    }
    
    static public func handleNoNetwork() {
        if let logDate = noNetworkDate {
            let now = Date()
            if now.timeIntervalSince(logDate) > 10 {
                ArkActivityView.showMessage("No network found. Please connect to internet.")
                noNetworkDate = now
            } else {
                return
            }
        } else {
            let now = Date()
            ArkActivityView.showMessage("No network found. Please connect to internet.")
            noNetworkDate = now
        }
    }
}

// Home
public extension ArkDataManager {
    
    public func updateHomeInfo() {
        guard Reachability.isConnectedToNetwork() == true else {
            ArkDataManager.handleNoNetwork()
            return
        }
        
        let settings = Settings.getSettings()
        let requestData = RequestData(myClass: self)
        
        ArkService.sharedInstance.requestDelegate(settings: settings, listener: requestData)
        ArkService.sharedInstance.requestAccount(settings: settings, listener: requestData)
        ArkService.sharedInstance.requestForging(settings: settings, listener: requestData)
        ArkService.sharedInstance.requestStatus(settings: settings, listener: requestData)
        ArkService.sharedInstance.requestPeerVersion(settings: settings, listener: requestData)
        ArkService.sharedInstance.requestLastBlockForged(settings: settings, listener: requestData)
        
        let requestTicker = RequestTicker(myClass: self)
        let requestBitcoinUSDTicker = RequestBitcoinUSDTicker(myClass: self)
        let requestBitcoinEURTicker = RequestBitcoinEURTicker(myClass: self)
        
        ExchangeService.sharedInstance.requestTicker(listener: requestTicker)
        ExchangeService.sharedInstance.requestBitcoinUSDTicker(listener: requestBitcoinUSDTicker)
        ExchangeService.sharedInstance.requestBitcoinEURTicker(listener: requestBitcoinEURTicker)
    }
    
    private class RequestData: RequestListener {
        let selfReference: ArkDataManager
        
        init(myClass: ArkDataManager){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            handleError()
        }
        
        func onResponse(object: Any)  -> Void {
            if let account = object as? Account {
                Home.account = account
                Home.balance = Double(account.balance)
                ArkNotificationManager.postNotification(.homeUpdated)
            }
            
            if let delegate = object as? Delegate {
                Home.delegate = delegate
                ArkNotificationManager.postNotification(.homeUpdated)
            }
            
            if let forging = object as? Forging {
                Home.forging = forging
                ArkNotificationManager.postNotification(.homeUpdated)
            }
            
            if let status = object as? Status {
                Home.status = status
                ArkNotificationManager.postNotification(.homeUpdated)
            }
            
            if let peerVersion = object as? PeerVersion {
                Home.peerVersion = peerVersion
                ArkNotificationManager.postNotification(.homeUpdated)
            }
            
            if let block = object as? Block {
                Home.block = block
                ArkNotificationManager.postNotification(.homeUpdated)
            }
        }
    }
    
    private class RequestTicker: RequestListener {
        let selfReference: ArkDataManager
        
        init(myClass: ArkDataManager){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            handleError()
        }
        
        func onResponse(object: Any)  -> Void {
            if let ticker = object as? Ticker {
                Home.arkBTCValue = ticker.last
                ArkNotificationManager.postNotification(.homeUpdated)
            }
        }
    }
    
    
    private class RequestBitcoinUSDTicker: RequestListener {
        let selfReference: ArkDataManager
        
        init(myClass: ArkDataManager){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            handleError()
        }
        
        func onResponse(object: Any)  -> Void {
            if let ticker = object as? Ticker {
                Home.bitcoinUSDValue = ticker.last
                ArkNotificationManager.postNotification(.homeUpdated)
            }
        }
    }
    
    private class RequestBitcoinEURTicker: RequestListener {
        let selfReference: ArkDataManager
        
        init(myClass: ArkDataManager){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            handleError()
        }
        
        func onResponse(object: Any)  -> Void {
            if let ticker = object as? Ticker {
                Home.bitcoinEURValue = ticker.last
                print(ticker.last)
                ArkNotificationManager.postNotification(.homeUpdated)
            }
        }
    }
}

// Forged Blocks
public extension ArkDataManager {
    
    public func updateForgedBlocks() {
        guard Reachability.isConnectedToNetwork() == true else {
            ArkDataManager.handleNoNetwork()
            return
        }
        
        let settings = Settings.getSettings()
        let requestBlocks = RequestBlocks(myClass: self)
        ArkService.sharedInstance.requestBlocks(settings: settings, listener: requestBlocks)
    }
    
    private class RequestBlocks: RequestListener {
        let selfReference: ArkDataManager
        
        init(myClass: ArkDataManager) {
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            handleError()
        }
        
        func onResponse(object: Any)  -> Void {
            let blocks = object as! [Block]
            ForgedBlocks.blocks = blocks
            ArkNotificationManager.postNotification(.forgedBlocksUpdated)
        }
    }
}

// Transactions
public extension ArkDataManager {
    
    public func updateLatestTransactions() {
        
        guard Reachability.isConnectedToNetwork() == true else {
            ArkDataManager.handleNoNetwork()
            return
        }
        
        let settings = Settings.getSettings()
        let requestTransactions = RequestTransactions(myClass: self)
        ArkService.sharedInstance.requestLatestTransactions(settings: settings, listener: requestTransactions)
    }
    
    private class RequestTransactions: RequestListener {
        let selfReference: ArkDataManager
        
        init(myClass: ArkDataManager){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            handleError()
        }
        
        func onResponse(object: Any)  -> Void {
            let transactions = object as! [Transaction]
            Transactions.transactions = transactions
        }
    }
}

// Delegates
public extension ArkDataManager {
    
    public func updateDelegates() {
        
        guard Reachability.isConnectedToNetwork() == true else {
            ArkDataManager.handleNoNetwork()
            return
        }
        
        let requestActiveDelegates = RequestActiveDelegates(myClass: self)
        let requestStandbyDelegates = RequestStandbyDelegates(myClass: self)
        
        let settings = Settings.getSettings()
        ArkService.sharedInstance.requestActiveDelegates(settings: settings, listener: requestActiveDelegates)
        ArkService.sharedInstance.requestStandyByDelegates(settings: settings, listener: requestStandbyDelegates)
    }
    
    private class RequestActiveDelegates: RequestListener {
        let selfReference: ArkDataManager
        
        init(myClass: ArkDataManager){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            handleError()
        }
        
        func onResponse(object: Any)  -> Void {
            var currentDelegates = object as! [Delegate]
            currentDelegates.sort { $0.rate < $1.rate }
            Delegates.delegates = currentDelegates
            ArkNotificationManager.postNotification(.delegatesUpdated)
        }
    }
    
    
    private class RequestStandbyDelegates: RequestListener {
        let selfReference: ArkDataManager
        
        init(myClass: ArkDataManager){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            handleError()
        }
        
        func onResponse(object: Any)  -> Void {
            var currentDelegates = object as! [Delegate]
            currentDelegates.sort { $0.rate < $1.rate }
            Delegates.standByDelegates = currentDelegates
            ArkNotificationManager.postNotification(.delegatesUpdated)
        }
    }
}

// Misc
public extension ArkDataManager {
    
    public func updateMisc() {
        
        guard Reachability.isConnectedToNetwork() == true else {
            ArkDataManager.handleNoNetwork()
            return
        }
        
        let settings = Settings.getSettings()
        
        let requestPeers = RequestPeers(myClass: self)
        ArkService.sharedInstance.requestPeers(settings: settings, listener: requestPeers)
        
        let requestVotes = RequestVotes(myClass: self)
        ArkService.sharedInstance.requestVotes(settings: settings, listener: requestVotes)
        
        let requestVoters = RequestVoters(myClass: self)
        ArkService.sharedInstance.requestVoters(settings: settings, listener: requestVoters)
    }
    
    private class RequestPeers: RequestListener {
        let selfReference: ArkDataManager
        
        init(myClass: ArkDataManager){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            handleError()
        }
        
        func onResponse(object: Any)  -> Void {
            var peers = object as! [Peer]
            peers.sort { $0.status > $1.status }
            
            ArkDataManager.Misc.peers = peers
            ArkNotificationManager.postNotification(.miscUpdated)
        }
    }
    
    private class RequestVotes: RequestListener {
        let selfReference: ArkDataManager
        
        init(myClass: ArkDataManager){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            handleError()
        }
        
        func onResponse(object: Any)  -> Void {
            var votes = (object as! Votes).delegates
            votes.sort { $0.rate < $1.rate }
            
            ArkDataManager.Misc.votes = votes
            ArkNotificationManager.postNotification(.miscUpdated)
        }
    }
    
    private class RequestVoters: RequestListener {
        let selfReference: ArkDataManager
        
        init(myClass: ArkDataManager) {
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            handleError()
        }
        
        func onResponse(object: Any)  -> Void {
            var voters = (object as! Voters).accounts
            voters.sort { $0.balance > $1.balance }
            
            ArkDataManager.Misc.voters = voters
            ArkNotificationManager.postNotification(.miscUpdated)
        }
    }
}









