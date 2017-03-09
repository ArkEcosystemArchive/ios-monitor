//
//  ExchangeService.swift
//  ArkMonitor
//
//  Created by Victor Lins on 23/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import Alamofire

class ExchangeService: NSObject {
    
    private static let urlTicker = "https://poloniex.com/public?command=returnTicker";
    private static let currencyPair = "BTC_LSK"
    
    private static let bitcoinEurUrlTicker = "https://www.bitstamp.net/api/v2/ticker/btceur/"
    private static let bitcoinUsdUrlTicker = "https://www.bitstamp.net/api/v2/ticker/btcusd/"


    static let sharedInstance : ExchangeService = {
        let instance = ExchangeService()
        return instance
    }()

    override init() {

    }
    
    public func requestTicker(listener : RequestListener) -> Void {

        Alamofire.request(ExchangeService.urlTicker).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                
                if let ticketJson = response.object(forKey: ExchangeService.currencyPair) as? NSDictionary {
                    
                    listener.onResponse(object: Ticker.fromJson(objectJson: ticketJson))
                } else {
                    listener.onResponse(object: Ticker())
                }

                
            case .failure(let error):
                listener.onFailure(e: error)
            }
        }
        
    }
    
    public func requestBitcoinUSDTicker(listener : RequestListener) -> Void {
        self.requestBitcoinTicker(url: ExchangeService.bitcoinUsdUrlTicker, listener: listener);
    }
    
    public func requestBitcoinEURTicker(listener : RequestListener) -> Void {
        self.requestBitcoinTicker(url: ExchangeService.bitcoinEurUrlTicker, listener: listener);
    }


    public func requestBitcoinTicker(url : String, listener : RequestListener) -> Void {
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                
                listener.onResponse(object: Ticker.fromJson(objectJson: response))

            case .failure(let error):
                listener.onFailure(e: error)
            }
        }
     }
   }
