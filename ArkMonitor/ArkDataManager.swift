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
import Disk


struct ArkDataManager {
    
    static var currentAccount: Account? {
        didSet {
            if currentAccount != nil {
                ArkNotificationManager.postNotification(.accountUpdated)
            }
        }
    }
    
    static var currentTransactions: [Transaction]? {
        didSet {
            if currentTransactions != nil {
                ArkNotificationManager.postNotification(.transactionsUpdated)
            }
        }
    }
    
    static var currentDelegates: [Delegate]? {
        didSet {
            if currentTransactions != nil {
                ArkNotificationManager.postNotification(.delegateListUpdated)
            }
        }
    }
    
    static var currentVote: Delegate? {
        didSet {
            if currentVote != nil {
                ArkNotificationManager.postNotification(.accountVoteUpdated)
            }
        }
    }
    
    static var currentAddress: String? {
        get {
            return UserDefaults.standard.string(forKey: "currentAddress")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "currentAddress")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var currentPublickey: String? {
        get {
            return UserDefaults.standard.string(forKey: "currentPublickey")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "currentPublickey")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var currentCurrency: Currency {
        get {
            guard let currencyString = UserDefaults.standard.string(forKey: "currentCurrency") else {
                return .usd
            }
            
            if let currentCurrency = Currency(rawValue: currencyString) {
                return currentCurrency
            } else {
                return .usd
            }
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "currentCurrency")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var tickerInfo: TickerStruct? {
        get {
            guard let dict = UserDefaults.standard.dictionary(forKey: "tickerInfo") else {
                return nil
            }
            return TickerStruct(dict: dict as [String : AnyObject])
        }
        set {
            guard let tickerStruct = newValue?.dictionary else {
                UserDefaults.standard.removeSuite(named: "tickerInfo")
                return
            }
            
            UserDefaults.standard.set(tickerStruct, forKey: "tickerInfo")
            UserDefaults.standard.synchronize()
            ArkNotificationManager.postNotification(.tickerUpdated)
        }
    }
    
    static var showTransactionNotifications: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "showTransactionNotifications")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "showTransactionNotifications")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var showDelegateNotifications: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "showDelegateNotifications")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "showDelegateNotifications")
            UserDefaults.standard.synchronize()
        }
    }
    
    static let manager = ArkManager()
    
    static public func registerWithAccount(_ account: Account) {
        manager.updateSettings(account: account)
        manager.updateNetworkPreset(.arknet1)
        currentAddress   = account.address
        currentPublickey = account.publicKey
        updateAccount()
        updateAccountVote()
        updateTransactions()
        updateTicker()
        updateDelegateList()
    }
    
    static public func startupOperations() {
        ArkNetworkManager.setNetwork(manager)
        if let address  = currentAddress,
           let publicKey = currentPublickey {
            let settings = Settings(address: address, publicKey: publicKey)
            manager.updateSettings(settings: settings)
            updateAccount()
            updateAccountVote()
            updateTransactions()
        }
        updateTicker()
        updateDelegateList()
    }
    
    static public func logoutOperations() {
        manager.removeSettings()
        currentAccount      = nil
        currentPublickey    = nil
        currentAddress      = nil
        currentVote         = nil
        currentTransactions = nil
        try? Disk.remove("account.json",      from: .documents)
        try? Disk.remove("myDelegate.json",   from: .documents)
        try? Disk.remove("transactions.json", from: .documents)
        ArkNotificationManager.postNotification(.accountLogout)
    }
    
    static public func updateCurrency(_ currency: Currency) {
        currentCurrency = currency
        updateTicker()
    }
    
    static func updateAccount() {
        retrieveAccountFromDisk()
        fetchAccount()
    }
    
    static func updateAccountVote() {
        retrieveVoteFromDisk()
        fetchMyVote()
    }
    
    static func updateTransactions() {
        retrieveTransactionsFromDisk()
        fetchTransactions()
    }
    
    static func updateTicker() {
        fetchTicker()
    }
    
    static func updateDelegateList() {
        retrieveDelegateListFromDisk()
        fetchDelegates()
    }
    
    static public func checkDelegateForChanges(_ newDelegate: Delegate) {
        do {
            let retrievedDelegate = try Disk.retrieve("myDelegate.json", from: .documents, as: Delegate.self)
            if newDelegate.isForging == retrievedDelegate.isForging {
                // nothing is changed
                return
            } else {
                ArkPushNotificationManager.updateDelegateForgingStatus(newDelegate)
            }
            self.currentVote = newDelegate
            do {
                try Disk.save(newDelegate, to: .documents, as: "myDelegate.json")
            } catch let error {
                print(error)
            }
         } catch let error {
            print(error)
            return
        }
    }
    
    static public func checkForNewTransactions(_ transactions: [Transaction]) {
        guard let newestCurrentTransaction = currentTransactions?.first else {
            return
        }
        
        let newTransactions = transactions.filter {$0.timestamp > newestCurrentTransaction.timestamp}
        
        for newTransaction in newTransactions {
            ArkPushNotificationManager.newTransactionNotification(newTransaction)
        }
        do {
            try Disk.save(transactions, to: .documents, as: "transactions.json")
        } catch let error {
            print(error)
        }
    }
    
    static private func retrieveAccountFromDisk() {
        if let retrievedAccount = try? Disk.retrieve("account.json", from: .documents, as: Account.self) {
            currentAccount = retrievedAccount
        }
    }
    
    static private func fetchAccount() {
        manager.account { (error, account) in
            ArkActivityView.checkNetworkError(error)
            if let fetchedAccount = account {
                self.currentAccount = fetchedAccount
                try? Disk.save(fetchedAccount, to: .documents, as: "account.json")
            }
        }
    }
    
    static private func retrieveVoteFromDisk() {
        do {
            let retrievedVote = try Disk.retrieve("myDelegate.json", from: .documents, as: Delegate.self)
            self.currentVote = retrievedVote
        } catch let error {
            print(error)
        }
    }
    
    static private func fetchMyVote() {
        manager.votes { (error, votes) in
            ArkActivityView.checkNetworkError(error)
            if let currentVote = votes?.first {
                self.currentVote = currentVote
                do {
                    try Disk.save(currentVote, to: .documents, as: "myDelegate.json")
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    static private func retrieveTransactionsFromDisk() {
        do {
            let retrievedTransactions = try Disk.retrieve("transactions.json", from: .documents, as: [Transaction].self)
            self.currentTransactions = retrievedTransactions
        } catch let error {
            print(error)
        }
    }
    
    static private func fetchTransactions() {
        manager.myTransactions { (error, transactions) in
            ArkActivityView.checkNetworkError(error)
            if let fetchedTransactions = transactions {
                self.currentTransactions = fetchedTransactions
                do {
                    try Disk.save(fetchedTransactions, to: .documents, as: "transactions.json")
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    static private func fetchTicker() {
        manager.ticker(currency: currentCurrency) { (error, ticker) in
            ArkActivityView.checkNetworkError(error)
            if let myTicker = ticker {
                let tickerStuct = TickerStruct(myTicker)
                self.tickerInfo = tickerStuct
            }
        }
    }
    
    static private func retrieveDelegateListFromDisk() {
        do {
            let retrievedDelegates = try Disk.retrieve("delegates.json", from: .documents, as: [Delegate].self)
            self.currentDelegates = retrievedDelegates
        } catch let error {
            print(error)
        }
    }
    
    static private func fetchDelegates() {
        manager.delegates { (error, delegates) in
            ArkActivityView.checkNetworkError(error)
            if let currentDelegates = delegates {
                self.manager.standbyDelegates { (error, standByDelegates) in
                    if let currentStandbyDelegates = standByDelegates {
                        let totalDelegates = currentDelegates + currentStandbyDelegates
                        self.currentDelegates = totalDelegates
                        do {
                            try Disk.save(totalDelegates, to: .documents, as: "delegates.json")
                        } catch let error {
                            print(error)
                        }
                    }
                }
            }
        }
    }
}

struct TickerStruct {
    public let currency     : Currency
    public let price        : Double
    public let bitcoinPrice : Double
    
    init(_ ticker: Ticker) {
        self.currency     = ticker.currency
        self.price        = ticker.price
        self.bitcoinPrice = ticker.bitcoinPrice
    }
    
    init?(dict: [String: AnyObject]) {
        guard let currency     = dict["currency"]     as? String,
              let price        = dict["price"]        as? Double,
              let bitcoinPrice = dict["bitcoinPrice"] as? Double else {
                return nil
        }
        
        guard let currencyEnum = Currency(rawValue: currency) else {
            return nil
        }
        self.currency     = currencyEnum
        self.price        = price
        self.bitcoinPrice = bitcoinPrice
    }
    
    public var dictionary: [String: AnyObject] {
        return [ "currency"     : currency.rawValue as AnyObject,
                 "price"        : price             as AnyObject,
                 "bitcoinPrice" : bitcoinPrice      as AnyObject
        ]
    }
}










