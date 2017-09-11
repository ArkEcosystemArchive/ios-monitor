//
//  LatestTransactionsViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 22/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class LatestTransactionsViewController: UIViewController {
    
    @IBOutlet weak var tableView   : UITableView!
    fileprivate var refreshControl : UIRefreshControl!

    var transactions : [Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Latest Transactions"
        
        setNavigationBarItem()
        
        tableView.registerCellNib(TransactionTableViewCell.self)
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(updateTableView), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        loadTransactions(true)
    }
    
    func loadTransactions(_ animated: Bool) -> Void {
        guard Reachability.isConnectedToNetwork() == true else {
            ArkActivityView.showMessage("Please connect to internet.")
            return
        }
        
        if animated == true {
            ArkActivityView.startAnimating()
        }
        
        let settings = Settings.getSettings()

        let requestTransactions = RequestTransactions(myClass: self)
        
        transactions = []
        tableView.reloadData()

        ArkService.sharedInstance.requestLatestTransactions(settings: settings, listener: requestTransactions)
    }
    
    private class RequestTransactions: RequestListener {
        let selfReference: LatestTransactionsViewController
        
        init(myClass: LatestTransactionsViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
        }
        
        func onResponse(object: Any)  -> Void {
            let transactions = object as! [Transaction]
            
            selfReference.transactions = transactions

            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
            selfReference.tableView.reloadData()
        }
    }
    
    @objc private func updateTableView() {
        loadTransactions(false)
    }
    
}

extension LatestTransactionsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TransactionTableViewCell.height()
    }
    
}

extension LatestTransactionsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier, for: indexPath) as! TransactionTableViewCell
        
        cell.setData(transactions[indexPath.row])
        return cell
    }
    
}
