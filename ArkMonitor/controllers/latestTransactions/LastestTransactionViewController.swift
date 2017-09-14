//
//  LastestTransactionViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class LastestTransactionsViewController: ArkViewController {
    
    fileprivate var tableView      : ArkTableView!
    
    fileprivate var transactions : [Transaction] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Transactions"
        
        tableView = ArkTableView(frame: CGRect.zero)
        tableView.delegate       = self
        tableView.dataSource     = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(transactionsUpdateNotification), name: NSNotification.Name(rawValue: ArkNotifications.transactionsUpdated.rawValue), object: nil)
        getDataFromDataManager()
        loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func loadData() {
        ArkDataManager.shared.updateLatestTransactions()
    }
    
    @objc private func transactionsUpdateNotification() {
        getDataFromDataManager()
    }
    
    private func getDataFromDataManager() {
        transactions = ArkDataManager.Transactions.transactions
        tableView.reloadData()
    }

}

// MARK: UITableViewDelegate
extension LastestTransactionsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = LatestTransactionsSectionHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 35.0))
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let aCell = cell as? LatestTransactionTableViewCell {
            aCell.update(transactions[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TransactionDetailViewController(transactions[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: UITableViewDatasource
extension LastestTransactionsViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "transaction") as? LatestTransactionTableViewCell
        if cell == nil {
            cell = LatestTransactionTableViewCell(style: .default, reuseIdentifier: "transaction")
        }
        return cell!
    }
}
