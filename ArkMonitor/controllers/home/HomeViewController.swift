//
//  HomeViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 22/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rankStatusLabel: UILabel!
    @IBOutlet weak var productivityLabel: UILabel!
    @IBOutlet weak var forgedMissedBlocksLabel: UILabel!
    @IBOutlet weak var approvalLabel: UILabel!
    @IBOutlet weak var forgedLabel: UILabel!
    @IBOutlet weak var lastBlockForgedLabel: UILabel!
    @IBOutlet weak var feesLabel: UILabel!
    @IBOutlet weak var rewardsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var totalBalanceLabel: UILabel!
    @IBOutlet weak var btcEquivalentLabel: UILabel!
    @IBOutlet weak var usdEquivalentLabel: UILabel!
    @IBOutlet weak var eurEquivalentLabel: UILabel!
    @IBOutlet weak var totalBlocksLabel: UILabel!
    @IBOutlet weak var blocksRemainingLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    fileprivate var refreshControl : UIRefreshControl!
    
    private var account : Account = Account()
    private var delegate : Delegate = Delegate()
    private var forging : Forging = Forging()
    private var status : Status = Status()
    private var peerVersion : PeerVersion = PeerVersion()
    private var block : Block = Block()
    
    private var balance : Double = -1
    private var arkBTCValue : Double = -1
    private var bitcoinUSDValue : Double = -1
    private var bitcoinEURValue : Double = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Home"
        
        setNavigationBarItem()
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(reloadPage), for: .valueChanged)
        
        scrollView.addSubview(refreshControl)

    }

    override func viewWillAppear(_ animated: Bool) {
        loadData(true)
    }

    func loadData(_ animated: Bool) -> Void {
        
        guard Reachability.isConnectedToNetwork() == true else {
            ArkActivityView.showMessage("Please connect to internet.")
            return
        }
        
        if animated == true {
            ArkActivityView.startAnimating()
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

    private func loadAccount() -> Void {
        if (account.address.length > 0) {
            totalBalanceLabel.text = String(Utils.convertToArkBase(value: account.balance))
            balance = Double(account.balance)
            calculateEquivalentInBitcoinUSDandEUR()
        }
    }
    
    
    private func loadDelegate() -> Void {
        if (delegate.address.length > 0) {
            nameLabel.text = delegate.username

            let rankStatus : String = delegate.rate <= 51 ? "Active" : "Standby"
            rankStatusLabel.text = String(delegate.rate) + " / " + rankStatus

            productivityLabel.text = String(delegate.productivity) + "%"
            approvalLabel.text = String(delegate.approval) + "%"
            addressLabel.text = delegate.address
            
            forgedMissedBlocksLabel.text = String(delegate.producedblocks) + " / " + String(delegate.missedblocks)
            
        }
    }
    
    private func loadForging() -> Void {
        feesLabel.text =  String(Utils.convertToArkBase(value: forging.fees))
        rewardsLabel.text =  String(Utils.convertToArkBase(value: forging.rewards))
        forgedLabel.text =  String(Utils.convertToArkBase(value: forging.forged))
    }
    
    private func loadStatus() -> Void {
        totalBlocksLabel.text =  String(status.height)
        blocksRemainingLabel.text = String(status.blocks)
    }
    
    private func loadPeerVersion() -> Void {
        versionLabel.text =  peerVersion.version
    }
    
    private func loadLastBlockForged() -> Void {
        lastBlockForgedLabel.text =  Utils.getTimeAgo(timestamp: Double(block.timestamp))
    }
    
    private func calculateEquivalentInBitcoinUSDandEUR() -> Void {
        if (balance > 0 && arkBTCValue > 0) {
            let balanceBtcEquivalent = balance * arkBTCValue
            totalBalanceLabel.text = String(Utils.convertToArkBase(value: Int64(balance)))
            
            btcEquivalentLabel.text = String(Utils.convertToArkBase(value: Int64(balanceBtcEquivalent)))

            if (bitcoinUSDValue > 0) {
                let balanceUSDEquivalent = balanceBtcEquivalent * bitcoinUSDValue
                usdEquivalentLabel.text = String(Utils.convertToArkBase(value: Int64(balanceUSDEquivalent)))
            }
            
            if (bitcoinEURValue > 0) {
                let balanceEUREquivalent = balanceBtcEquivalent * bitcoinEURValue
                eurEquivalentLabel.text = String(Utils.convertToArkBase(value: Int64(balanceEUREquivalent)))
            }
        }
    }
    
    private class RequestData: RequestListener {
        let selfReference: HomeViewController
        
        init(myClass: HomeViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
        }
        
        func onResponse(object: Any)  -> Void {
            if let account = object as? Account {
                selfReference.account = account
                selfReference.loadAccount()
            }
            
            if let delegate = object as? Delegate {
                selfReference.delegate = delegate
                selfReference.loadDelegate()
            }
            
            if let forging = object as? Forging {
                selfReference.forging = forging
                selfReference.loadForging()
            }
            
            if let status = object as? Status {
                selfReference.status = status
                selfReference.loadStatus()
            }
            
            if let peerVersion = object as? PeerVersion {
                selfReference.peerVersion = peerVersion
                selfReference.loadPeerVersion()
            }
            
            if let block = object as? Block {
                selfReference.block = block
                selfReference.loadLastBlockForged()
            }
            
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
            
        }
    }
    
    
    private class RequestTicker: RequestListener {
        let selfReference: HomeViewController
        
        init(myClass: HomeViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
            selfReference.arkBTCValue = -1
        }
        
        func onResponse(object: Any)  -> Void {
            if let ticker = object as? Ticker {
                selfReference.arkBTCValue = ticker.last
                selfReference.calculateEquivalentInBitcoinUSDandEUR()
            }
            
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
            
        }
    }
    
    
    private class RequestBitcoinUSDTicker: RequestListener {
        let selfReference: HomeViewController
        
        init(myClass: HomeViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
            selfReference.bitcoinUSDValue = -1
        }
        
        func onResponse(object: Any)  -> Void {
            if let ticker = object as? Ticker {
                selfReference.bitcoinUSDValue = ticker.last
                selfReference.calculateEquivalentInBitcoinUSDandEUR()
            }
            
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
            
        }
    }
    
    private class RequestBitcoinEURTicker: RequestListener {
        let selfReference: HomeViewController
        
        init(myClass: HomeViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
            
        }

        func onResponse(object: Any)  -> Void {
            if let ticker = object as? Ticker {
                selfReference.bitcoinEURValue = ticker.last
                selfReference.calculateEquivalentInBitcoinUSDandEUR()

            }
            
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
            
        }
    }
    
    @objc private func reloadPage() {
        loadData(false)
    }
}
