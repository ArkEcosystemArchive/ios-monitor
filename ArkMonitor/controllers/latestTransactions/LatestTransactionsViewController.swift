//
//  LatestTransactionsViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 22/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit
import Toaster
import ESPullToRefresh
import NVActivityIndicatorView

class LatestTransactionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var transactions : [Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Latest Transactions"
        
        setNavigationBarItem()
        
        self.tableView.registerCellNib(TransactionTableViewCell.self)
        
        _ = self.tableView.es_addPullToRefresh {
            [weak self] in
            
            self?.loadTransactions()
            
            self?.tableView.es_stopPullToRefresh()
        }
        
        loadTransactions()
    }
    
    func loadTransactions() -> Void {
        if (!Reachability.isConnectedToNetwork()) {
            Toast(text: "Please connect to internet.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            
            return
        }
        
        let activityData = ActivityData(type: NVActivityIndicatorType.lineScale)
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        let settings = Settings.getSettings()

        let requestTransactions = RequestTransactions(myClass: self)
        
        self.transactions = []
        self.tableView.reloadData()

        ArkService.sharedInstance.requestLatestTransactions(settings: settings, listener: requestTransactions)
    }
    
    private class RequestTransactions: RequestListener {
        let selfReference: LatestTransactionsViewController
        
        init(myClass: LatestTransactionsViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            Toast(text: "Unable to retrieve data. Please try again later.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
        
        func onResponse(object: Any)  -> Void {
            let transactions = object as! [Transaction]
            
            selfReference.transactions = transactions

            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            selfReference.tableView.reloadData()
        }
    }
    
}

extension LatestTransactionsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TransactionTableViewCell.height()
    }
    
}

extension LatestTransactionsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier, for: indexPath) as! TransactionTableViewCell
        
        cell.setData(self.transactions[indexPath.row])
        return cell
    }
    
}
