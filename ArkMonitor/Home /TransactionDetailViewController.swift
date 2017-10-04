//
//  TransactionDetailViewController.swift
//  Dark
//
//  Created by Andrew on 2017-09-22.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit
import SwiftyArk

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

        tableView = ArkTableView(CGRect.zero)
        tableView.delegate       = self
        tableView.dataSource     = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: UITableViewDelegate
extension TransactionDetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 35.0))
        headerView.backgroundColor = ArkPalette.secondaryBackgroundColor
        
        let headerLabel = UILabel(frame: CGRect(x: 12.5, y: 0.0, width: _screenWidth - 12.5, height: 35.0))
        headerLabel.textColor = ArkPalette.highlightedTextColor
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  .semibold)
        
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
        case 6:
            headerLabel.text = "Confirmations"
        default:
            headerLabel.text = "Vendor Field"
        }
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 65.0
        }
        return 45.0
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
        if transaction.vendorField != nil {
            return 8
        } else {
            return 7
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var titleString   = ""
        var numberOfLines = 1
        
        switch indexPath.section {
        case 0:
            titleString = transaction.id
            numberOfLines = 2
        case 1:
            titleString = transaction.timestamp.longStyleDateString
        case 2:
            titleString = transaction.senderId
        case 3:
            titleString = transaction.recipientId
        case 4:
            titleString = String(transaction.amount)
        case 5:
            titleString = String(transaction.fee)
        case 6:
            titleString = String(transaction.confirmations)
        default:
            titleString = transaction.vendorField ?? ""
        }
        
        let cell = ArkDetailTableViewCell(titleString, numberOfLines: numberOfLines)
        return cell
    }
}

