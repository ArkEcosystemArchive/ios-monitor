//
//  TransactionDetailViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class TransactionDetailViewController: ArkViewController {
    
    fileprivate let transaction : Transaction
    fileprivate var tableView   : ArkTableView!
    
    init(_ transaction: Transaction) {
        self.transaction = transaction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Detail"

        tableView = ArkTableView(frame: CGRect.zero)
        tableView.delegate       = self
        tableView.dataSource     = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override func colorsUpdated() {
        super.colorsUpdated()
        tableView.reloadData()
        tableView.backgroundColor = ArkPalette.backgroundColor
    }
}

// MARK: UITableViewDelegate
extension TransactionDetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
        headerView.backgroundColor = ArkPalette.backgroundColor
        
        let headerLabel = UILabel(frame: CGRect(x: 12.5, y: 0.0, width: _screenWidth - 12.5, height: 40.0))
        headerLabel.textColor = ArkPalette.textColor
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.systemFont(ofSize: 18.0, weight:  ArkPalette.fontWeight)
        
        switch section {
        case 0:
            headerLabel.text = "Transaction ID"
        case 1:
            headerLabel.text = "Time"
        case 2:
            headerLabel.text = "From"
        case 3:
            headerLabel.text = "To"
        case 4:
            headerLabel.text = "Amount"
        case 5:
            headerLabel.text = "Fee"
        default:
            headerLabel.text = "Confirmations"
        }
        headerView.addSubview(headerLabel)
        
        let seperator = UIView(frame: CGRect(x: 0.0, y: 39.5, width: _screenWidth, height: 0.5))
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        
        headerView.addSubview(seperator)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
}

// MARK: UITableViewDelegate
extension TransactionDetailViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var titleString = ""
        
        switch indexPath.section {
        case 0:
            titleString = transaction.id
        case 1:
            titleString = Utils.getTimeAgo(timestamp: Double(transaction.timestamp))
        case 2:
            titleString = transaction.senderId
        case 3:
            titleString = transaction.recipientId
        case 4:
            titleString = String(Utils.convertToArkBase(value: transaction.amount))
        case 5:
            titleString = String(Utils.convertToArkBase(value: Int64(transaction.fee)))
        default:
            titleString = String(transaction.confirmations)
        }
        
        let cell = TransactionDetailTableViewCell(titleString)
        return cell
    }
}

