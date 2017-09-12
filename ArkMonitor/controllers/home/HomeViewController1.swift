//
//  HomeViewController1.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController1: UIViewController {
    
    fileprivate var account : Account = Account()
    fileprivate var delegate : Delegate = Delegate()
    fileprivate var forging : Forging = Forging()
    fileprivate var status : Status = Status()
    fileprivate var peerVersion : PeerVersion = PeerVersion()
    fileprivate var block : Block = Block()
    
    fileprivate var tableView: UITableView!
    
    private var balance         : Double?
    private var arkBTCValue     : Double?
    private var bitcoinUSDValue : Double?
    private var bitcoinEURValue : Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    fileprivate func loadData() {
        
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
        let selfReference: HomeViewController1
        
        init(myClass: HomeViewController1){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            ArkActivityView.stopAnimating()
        }
        
        func onResponse(object: Any)  -> Void {
            if let account = object as? Account {
                selfReference.account = account
                selfReference.balance = Double(account.balance)
                selfReference.tableView.reloadData()
            }
            
            if let delegate = object as? Delegate {
                selfReference.delegate = delegate
                selfReference.tableView.reloadData()
            }
            
            if let forging = object as? Forging {
                selfReference.forging = forging
                selfReference.tableView.reloadData()
            }
            
            if let status = object as? Status {
                selfReference.status = status
                selfReference.tableView.reloadData()
            }
            
            if let peerVersion = object as? PeerVersion {
                selfReference.peerVersion = peerVersion
                selfReference.tableView.reloadData()
            }
            
            if let block = object as? Block {
                selfReference.block = block
                selfReference.tableView.reloadData()
            }
        }
    }
    
    private class RequestTicker: RequestListener {
        let selfReference: HomeViewController1
        
        init(myClass: HomeViewController1){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            ArkActivityView.stopAnimating()
        }
        
        func onResponse(object: Any)  -> Void {
            if let ticker = object as? Ticker {
                selfReference.arkBTCValue = ticker.last
                selfReference.tableView.reloadData()
            }
            
            ArkActivityView.stopAnimating()
        }
    }
    
    
    private class RequestBitcoinUSDTicker: RequestListener {
        let selfReference: HomeViewController1
        
        init(myClass: HomeViewController1){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            ArkActivityView.stopAnimating()
        }
        
        func onResponse(object: Any)  -> Void {
            if let ticker = object as? Ticker {
                selfReference.bitcoinUSDValue = ticker.last
                selfReference.tableView.reloadData()
            }
            
            ArkActivityView.stopAnimating()
        }
    }
    
    private class RequestBitcoinEURTicker: RequestListener {
        let selfReference: HomeViewController1
        
        init(myClass: HomeViewController1){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            ArkActivityView.stopAnimating()
        }
        
        func onResponse(object: Any)  -> Void {
            if let ticker = object as? Ticker {
                selfReference.bitcoinEURValue = ticker.last
                selfReference.tableView.reloadData()
            }
            ArkActivityView.stopAnimating()
        }
    }
}


// MARK: UITableViewDelegate
extension HomeViewController1: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let aCell = cell as? HomeDelegateTableViewCell {
            aCell.update(delegate)
        }
        
        if let aCell = cell as? HomeForgingTableViewCell {
            aCell.update(forging)
        }
        
        if let aCell = cell as? HomeLastBlockTableViewCell {
            aCell.update(block)
        }
        
        if let aCell = cell as? HomeBalanceTableViewCell {
            aCell.update(balance: balance, arkBTCValue: arkBTCValue, bitcoinUSDValue: bitcoinUSDValue, bitcoinEURValue: bitcoinEURValue)
        }
        
        if let aCell = cell as? HomeAddressTableViewCell {
            aCell.update(delegate)
        }
        
        if let aCell = cell as? HomeServerTableViewCell {
            aCell.update(status)
        }
        
        if let aCell = cell as? HomeVersionTableViewCell {
            aCell.update(peerVersion)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 50.0))
        headerView.backgroundColor = UIColor.white
        
        let headerLabel = UILabel(frame: CGRect(x: 12.5, y: 0.0, width: _screenWidth - 12.5, height: 50.0))
        headerLabel.textAlignment = .left
        headerLabel.textColor = ArkColors.blue
        
        switch section {
        case 0:
            headerLabel.text = "Delegate"
        case 1:
            headerLabel.text = "Forging"
        case 2:
            headerLabel.text = "Account"
        default:
            headerLabel.text = "Server"
        }
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    
}

// MARK: UITableViewDataSource
extension HomeViewController1: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 5
            case 1:
                return 4
            case 2:
                return 5
            default:
                return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = HomeDelegateTableViewCell(indexPath.row)
            return cell
        case 1:
            if indexPath.row == 3 {
                let cell = HomeLastBlockTableViewCell(indexPath.row)
                return cell
            } else {
                let cell = HomeForgingTableViewCell(indexPath.row)
                return cell
            }
        case 2:
            if indexPath.row == 0 {
                let cell = HomeAddressTableViewCell(indexPath.row)
                return cell
            } else {
                let cell = HomeBalanceTableViewCell(indexPath.row)
                return cell
            }
        case 3:
            if indexPath.row == 2 {
                let cell = HomeVersionTableViewCell(indexPath.row)
                return cell
            } else {
                let cell = HomeServerTableViewCell(indexPath.row)
                return cell
            }
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}
