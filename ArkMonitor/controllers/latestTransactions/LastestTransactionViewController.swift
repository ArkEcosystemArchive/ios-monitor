//
//  LastestTransactionViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class LastestTransactionsViewController: UIViewController {
    
    fileprivate var tableView      : UITableView!
    fileprivate var refreshControl : UIRefreshControl!
    
    fileprivate var transactions : [Transaction] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "whiteLogo"))
        
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.delegate       = self
        tableView.dataSource     = self
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = ArkColors.blue
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
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
        delay(0.75) {
            self.refreshControl.endRefreshing()
        }
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
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = LatestTransactionsSectionHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
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
