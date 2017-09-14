//
//  SettingsCustomServerViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-14.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class SettingsCustomServerViewController: ArkViewController {
    
    fileprivate var tableview     : ArkTableView!
    
    fileprivate var ipAddress : String?
    fileprivate var port      : Int?
    fileprivate var isSSL     = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Custom"
        tableview            = ArkTableView(frame: CGRect.zero)
        tableview.delegate   = self
        tableview.dataSource = self
        tableview.showEmptyNotice = false
                
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

// MARK: UITableViewDelegate
extension SettingsCustomServerViewController: UITableViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
        headerView.backgroundColor = ArkPalette.backgroundColor
        
        let headerLabel  = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
        headerLabel.font = UIFont.systemFont(ofSize: 18.0)
        headerLabel.text = "Custom Server Settings"

        headerLabel.textColor = ArkPalette.textColor
        headerLabel.textAlignment = .center
        
        headerView.addSubview(headerLabel)
        
        let seperator = UIView(frame: CGRect(x: 0.0, y: 39.5, width: _screenWidth, height: 0.5))
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        
        headerView.addSubview(seperator)
        return headerView    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 0, 1, 2:
                return 50
            default:
                return 100.0
        }
    }
}

// MARK: UITableViewDataSource
extension SettingsCustomServerViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = SettingsIPTableViewCell(.custom)
            cell.delegate = self
            return cell
        case 1:
            let cell = SettingsPortTableViewCell(.custom)
            cell.delegate = self
            return cell
        case 2:
            let cell = SettingsSSLTableViewCell(.custom)
            cell.delegate = self
            return cell
        default:
            let cell = SettingsSaveTableViewCell(.custom)
            cell.delegate = self
            return cell
        }
    }
}

// MARK: SettingsIPTableViewCellDelegate
extension SettingsCustomServerViewController : SettingsIPTableViewCellDelegate {
    func ipCell(_ cell: SettingsIPTableViewCell, didChangeText text: String?) {
        self.ipAddress = text
    }
}

// MARK: SettingsPortTableViewCellDelegate
extension SettingsCustomServerViewController : SettingsPortTableViewCellDelegate {
    func portCell(_ cell: SettingsPortTableViewCell, didChangeText text: String?) {
        if let portString = text {
            self.port = Int(portString)
        }
    }
}

// MARK: SettingsSSLTableViewCellDelegate
extension SettingsCustomServerViewController : SettingsSSLTableViewCellDelegate {
    func sslCell(_ cell: SettingsSSLTableViewCell, didChangeStatus enabled: Bool) {
        self.isSSL = enabled
    }
}

// MARK: SettingsSaveTableViewCellDelegate
extension SettingsCustomServerViewController : SettingsSaveTableViewCellDelegate {
    func saveCellButtonWasTapped(_ cell: SettingsSaveTableViewCell) {
        
        guard let ip = ipAddress else {
            ArkActivityView.showMessage("IP Address cannot be blank")
            return
        }
        
        guard let currentPort = port else {
            ArkActivityView.showMessage("Port cannot be blank")
            return
        }
        
        guard Utils.validateIpAddress(ipAddress: ip) else {
            ArkActivityView.showMessage("IP Address is invalid")
            return
        }
        
        guard Utils.validatePortStr(portStr: String(currentPort)) else {
            ArkActivityView.showMessage("Port is invalid")
            return
        }

        print(ip)
        print(currentPort)
        print(isSSL)
    }
}




