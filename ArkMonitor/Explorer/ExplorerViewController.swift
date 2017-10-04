//
//  ExplorerViewController.swift
//  Dark
//
//  Created by Andrew on 2017-09-28.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit
import SwiftyArk

class ExplorerViewController: ArkViewController {
    
    fileprivate var tableView    : ArkTableView!
    fileprivate var searchView   : UISearchBar!
    
    fileprivate var account     : Account?
    fileprivate var delegate    : Delegate?
    fileprivate var transaction : Transaction?
    fileprivate var block       : Block?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title     = "Explorer"
        tableView                = ArkTableView(CGRect.zero)
        tableView.delegate       = self
        tableView.dataSource     = self
    
        
        searchView = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 50.0))
        searchView.autocorrectionType = .no
        searchView.autocapitalizationType = .none
        searchView.updateColors()
        searchView.delegate = self
        tableView.tableHeaderView = searchView

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setTableData()
    }
    
    fileprivate func setTableData() {
        tableView.reloadData()
        
        if account != nil || delegate != nil || block != nil || transaction != nil {
            let backgroundView = UIView()
            tableView.backgroundView = backgroundView
            return
        }
        
        let emptyBackgroundView = UIView(frame: tableView.frame)
        let emptyLabel = UILabel()
        emptyLabel.textColor = ArkPalette.highlightedTextColor
        emptyLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        emptyLabel.textAlignment = .center
        if searchView.text == "" {
            emptyLabel.numberOfLines = 2
            emptyLabel.text = "Search for a block,transaction,\naddress, or delegate"
        } else {
            emptyLabel.numberOfLines = 1
            emptyLabel.text = "No matching records found!"
        }

        emptyBackgroundView.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        tableView.backgroundView = emptyBackgroundView
    }
    
    private func parseSearchString(_ searchText: String) {
        account     = nil
        transaction = nil
        block       = nil
        delegate    = nil
        setTableData()
        if searchText.count == 34 && (searchText.first == "A" || searchText.first == "D") {
            fetchAddress(searchText)
        } else if searchText.count == 64 {
            fetchTransaction(searchText)
        } else if searchText.count >= 19 && searchText.isNumeric() {
            fetchBlock(searchText)
        } else {
            fetchDelegate(searchText)
        }
    }
    
    private func fetchAddress(_ address: String) {
        ArkDataManager.manager.account(address: address) { (error, account) in
            if let searchedAccount = account {
                self.account = searchedAccount
                self.setTableData()
            }
        }
    }
    
    private func fetchTransaction(_ transactionID: String) {
        ArkDataManager.manager.transaction(id: transactionID) { (error, transaction) in
            if let searchedTransaction = transaction {
                self.transaction = searchedTransaction
                self.setTableData()
            }
        }
    }
    
    private func fetchBlock(_ blockID: String) {
        ArkDataManager.manager.block(blockID) { (error, block) in
            if let searchedBlock = block {
                self.block = searchedBlock
                self.setTableData()
            }
        }
    }
    
    private func fetchDelegate(_ delegateName: String) {
        ArkDataManager.manager.delegate(delegateName.lowercased()) { (error, delegate) in
            if let searchedDelegate = delegate {
                self.delegate = searchedDelegate
                self.setTableData()
            }
        }
    }
}

extension ExplorerViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 35.0))
        headerView.backgroundColor = ArkPalette.backgroundColor
        
        let headerLabel = UILabel(frame: CGRect(x: 12.5, y: 0.0, width: _screenWidth - 12.5, height: 35.0))
        headerLabel.textColor = ArkPalette.highlightedTextColor
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.systemFont(ofSize: 18.0, weight:  .semibold)
        if account != nil {
            headerLabel.text = "Account"
        }
        
        if delegate != nil {
            headerLabel.text = "Delegate"
        }
        
        if transaction != nil {
            headerLabel.text = "Transaction"
        }
        
        if block != nil {
            headerLabel.text = "Block"
        }
        
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchView.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ExplorerDelegateTableViewCell {
            let vc = DelegateDetailViewController(cell.delegate)
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? ExplorerTransactionTableViewCell {
            let vc = TransactionDetailViewController(cell.transaction)
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? ExplorerAccountTableViewCell {
            let vc = AccountDetailViewController(cell.account)
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? ExplorerBlockTableViewCell {
            let vc = BlockDetailViewController(cell.block)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ExplorerViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        if account != nil {
            count += 1
        }
        
        if delegate != nil {
            count += 1
        }
        
        if transaction != nil {
            count += 1
        }
        
        if block != nil {
            count += 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if transaction != nil {
            return 65.0
        } else {
            return 45.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let searchedAccount = account {
            let cell = ExplorerAccountTableViewCell(searchedAccount)
            return cell
        } else if let searchedDelegate = delegate {
            let cell = ExplorerDelegateTableViewCell(searchedDelegate)
            return cell
        } else if let searchedTransaction = transaction {
            let cell = ExplorerTransactionTableViewCell(searchedTransaction)
            return cell
        } else if let searchedBlock = block {
            let cell = ExplorerBlockTableViewCell(searchedBlock)
            return cell
        }
        else {
            let cell = UITableViewCell()
            return cell
        }
    }
}

extension ExplorerViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let searchText = searchBar.text else {
            return
        }
        
        parseSearchString(searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            account     = nil
            transaction = nil
            block       = nil
            delegate    = nil
            setTableData()
        }
    }
}

