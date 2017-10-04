//
//  SettingsViewController.swift
//  Dark
//
//  Created by Andrew on 2017-09-23.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit

class SettingsViewController: ArkViewController {

    fileprivate var tableView : ArkTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Settings"
        
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
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegate
extension SettingsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2,3:
            return 85.0
        default:
            return 45.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = tableView.cellForRow(at: indexPath) as? SettingsCurrencyTableViewCell {
            let vc = CurrencySelectionViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if let _ = tableView.cellForRow(at: indexPath) as? SettingsServerTableViewCell {
            let vc = ServerSelectionViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if let _ = tableView.cellForRow(at: indexPath) as? SettingsLogoutTableViewCell {
            ArkDataManager.logoutOperations()
        }
    }
}


// MARK: UITableViewDataSource
extension SettingsViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let currency = ArkDataManager.currentCurrency
            let cell = SettingsCurrencyTableViewCell(currency)
            return cell
        case 1:
            let cell = SettingsServerTableViewCell()
            return cell
        case 2:
            let cell = SettingsTransactionsNotificationTableViewCell(style: .default, reuseIdentifier: "transactions")
            return cell
        case 3:
            let cell = SettingsDelegateNotifcationTableViewCell(style: .default, reuseIdentifier: "delegate")
            return cell
        default:
            let cell = SettingsLogoutTableViewCell(style: .default, reuseIdentifier: "logout")
            return cell
        }
    }
}
