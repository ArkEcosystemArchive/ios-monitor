//
//  SettingSelectionViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-14.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class SettingSelectionViewController: ArkViewController {
    
    fileprivate var tableview     : ArkTableView!
    fileprivate var settings      : Settings = Settings()
    fileprivate var customServers =  [CustomServer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Server"
        tableview            = ArkTableView(frame: CGRect.zero)
        tableview.delegate   = self
        tableview.dataSource = self
        tableview.showEmptyNotice = false
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
    }
    
    private func loadSettings() {
        settings = Settings.getSettings()
        
        guard settings.isValid() == true else {
            return
        }
        tableview.reloadData()
    }
}

// MARK: UITableViewDelegate
extension SettingSelectionViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60.0
        }
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
        headerView.backgroundColor = ArkPalette.backgroundColor
        
        let headerLabel       = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
        headerLabel.font      = UIFont.systemFont(ofSize: 18.0)
        headerLabel.textColor = ArkPalette.textColor
        headerLabel.textAlignment = .center
        
        if section == 0 {
            headerLabel.text = "Username"
        } else {
            headerLabel.text = "Select Server"
        }

        headerView.addSubview(headerLabel)
        
        let seperator = UIView(frame: CGRect(x: 0.0, y: 39.5, width: _screenWidth, height: 0.5))
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        
        headerView.addSubview(seperator)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let aCell = cell as? SettingsSelectionUsernameTableViewCell {
            aCell.update(settings.username)
        }
        
        if let aCell = cell as? SettingSelectionPresetTableViewCell {
            if aCell.mode == settings.serverType {
                aCell.setServerSelction(true)
            } else {
                aCell.setServerSelction(false)
            }
        }
    }
}


// MARK: UITableViewDataSource
extension SettingSelectionViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return customServers.count + 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = SettingsSelectionUsernameTableViewCell(style: .default, reuseIdentifier: "username")
            return cell
        } else {
            switch indexPath.row {
            case 0:
                let cell = SettingSelectionPresetTableViewCell(.arkNet1)
                return cell
            case 1:
                let cell = SettingSelectionPresetTableViewCell(.arkNet2)
                return cell
            default:
                let cell = SettingsSelectionAddServerTableViewCell(style: .default, reuseIdentifier: "addCustomServer")
                return cell
            }
        }
    }
}
