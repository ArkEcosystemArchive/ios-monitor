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
    
    public func updateData() {
        updateHomeInfo()
    }

}

// Home
public extension ArkDataManager {
    
    public func updateHomeInfo() {
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
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
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
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
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
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
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
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
        }
        
        func onResponse(object: Any)  -> Void {
            if let ticker = object as? Ticker {
                Home.bitcoinEURValue = ticker.last
                ArkNotificationManager.postNotification(.homeUpdated)
            }
        }
    }
}
