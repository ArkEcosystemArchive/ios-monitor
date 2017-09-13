//
//  SettingViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-13.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    fileprivate var tableview: ArkTableView!
    fileprivate var mode : Server = .arkNet1
    
    fileprivate var username    : String?
    fileprivate var ipAddress   : String?
    fileprivate var port        : Int?
    fileprivate var sslEnabled  = false
    
    var settings: Settings = Settings()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview = ArkTableView(frame: CGRect.zero)
        tableview.showEmptyNotice = false
        tableview.delegate      = self
        tableview.dataSource = self
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        loadSettings()
    }
    
    private func loadSettings() {
        settings = Settings.getSettings()
        
        guard settings.isValid() == true else {
            return
        }
        
        username   = settings.username
        ipAddress  = settings.ipAddress
        sslEnabled = settings.sslEnabled
        mode       = settings.serverType
        if settings.port != -1 {
            port = settings.port
        }
        
        tableview.reloadData()
    }
}

// MARK: UITableViewDelegate
extension SettingViewController: UITableViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 50.0
        case 1:
            return 100.0
        case 2, 3, 4:
            if mode == .custom {
                return 50.0
            } else {
                return 0.0
            }
        case 5:
            return 70.0
        default:
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let aCell = cell as? SettingsUsernameTableViewCell {
            aCell.update(username)
        }
        
        if let aCell = cell as? SettingsServerTableViewCell {
            aCell.updateMode(mode)
        }
        
        if let aCell = cell as? SettingsIPTableViewCell {
            aCell.update(ipAddress)
        }
        
        if let aCell = cell as? SettingsPortTableViewCell {
            if let aPort = port {
                aCell.update(String(aPort))
            }
        }
        
        if let aCell = cell as? SettingsSSLTableViewCell {
            aCell.update(sslEnabled)
        }
    }
}

// MARK: UITableViewDataSource
extension SettingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = SettingsUsernameTableViewCell(mode)
            cell.delegate = self
            return cell
        case 1:
            let cell = SettingsServerTableViewCell(mode)
            cell.delegate = self
            return cell
        case 2:
            let cell = SettingsIPTableViewCell(mode)
            cell.delegate = self
            if mode != .custom {
                cell.isHidden = true
            }
            return cell
        case 3:
            let cell = SettingsPortTableViewCell(mode)
            cell.delegate = self
            if mode != .custom {
                cell.isHidden = true
            }
            return cell
        case 4:
            let cell = SettingsSSLTableViewCell(mode)
            cell.delegate = self
            if mode != .custom {
                cell.isHidden = true
            }
            return cell
        case 5:
            let cell = SettingsSaveTableViewCell(mode)
            cell.delegate = self
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}

// MARK: SettingsUsernameTableViewCellDelegate
extension SettingViewController: SettingsUsernameTableViewCellDelegate {
    func usernameCell(_ cell: SettingsUsernameTableViewCell, didChangeText text: String?) {
        self.username = text
    }
}

// MARK: SettingsServerTableViewCellDelegate
extension SettingViewController: SettingsServerTableViewCellDelegate {
    func serverCell(_ cell: SettingsServerTableViewCell, didChangeMode mode: Server) {
        self.mode = mode
        tableview.beginUpdates()
        
        let ipIndex = IndexPath(row: 0, section: 2)
        let portIndex = IndexPath(row: 0, section: 3)
        let sslIndex = IndexPath(row: 0, section: 4)

        let indexes : [IndexPath] = [ipIndex, portIndex, sslIndex]
        tableview.reloadRows(at: indexes, with: .fade)
        tableview.endUpdates()
        tableview.reloadData()
    }
}

// MARK: SettingsIPTableViewCellDelegate
extension SettingViewController : SettingsIPTableViewCellDelegate {
    func ipCell(_ cell: SettingsIPTableViewCell, didChangeText text: String?) {
        self.ipAddress = text
    }
}

// MARK: SettingsPortTableViewCellDelegate
extension SettingViewController : SettingsPortTableViewCellDelegate {
    func portCell(_ cell: SettingsPortTableViewCell, didChangeText text: String?) {
        if let portString = text {
            self.port = Int(portString)
        }
    }
}

// MARK: SettingsSSLTableViewCellDelegate
extension SettingViewController : SettingsSSLTableViewCellDelegate {
    func sslCell(_ cell: SettingsSSLTableViewCell, didChangeStatus enabled: Bool) {
        self.sslEnabled = enabled
    }
}

// MARK: SettingsSaveTableViewCellDelegate
extension SettingViewController: SettingsSaveTableViewCellDelegate {
    func saveCellButtonWasTapped(_ cell: SettingsSaveTableViewCell) {
        
        view.endEditing(true)

        guard Reachability.isConnectedToNetwork() == true else {
            ArkActivityView.showMessage("Please connect to internet.")
            return
        }
        
        let settings = Settings()
        
        guard let currentUserName = username else {
            ArkActivityView.showMessage("Username invalid.")
            return
        }
        
        if (!Utils.validateUsername(username: currentUserName)) {
            ArkActivityView.showMessage("Username invalid.")
            return
        }
        
        
        settings.username = currentUserName
        
        if mode == .custom {
            guard let currentIPAddress = ipAddress else {
                ArkActivityView.showMessage("Ip Address invalid.")
                return
            }
            
            if (!Utils.validateIpAddress(ipAddress: currentIPAddress)) {
                ArkActivityView.showMessage("Ip Address invalid.")
                return
            }
            
            guard let currentPort = port else {
                ArkActivityView.showMessage("Port invalid.")
                return
            }
            
            if (!Utils.validatePortStr(portStr: String(currentPort))) {
                ArkActivityView.showMessage("Port invalid.")
                return
            }
            
            settings.ipAddress  = currentIPAddress
            settings.port       = currentPort
            settings.sslEnabled = sslEnabled
        }
        
        settings.setServerType(serverType: mode)
        ArkService.sharedInstance.requestDelegate(settings: settings, listener: RequestData(myClass: self))
    }
    
    private class RequestData: RequestListener {
        let selfReference: SettingViewController
        
        init(myClass: SettingViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
        }
        
        func onResponse(object: Any)  -> Void {
            
            if let delegate = object as? Delegate {
                let settings = Settings.getSettings()
                
                settings.username = selfReference.username!
                settings.sslEnabled = selfReference.sslEnabled
                settings.setServerType(serverType: selfReference.mode)
                
                if let ipAddress = selfReference.ipAddress {
                    if (Utils.validateIpAddress(ipAddress: ipAddress)) {
                        settings.ipAddress = ipAddress
                    }
                }
                
                if let port = selfReference.port {
                    if (Utils.validatePortStr(portStr: String(port))) {
                        settings.port = Int(port)
                    }
                }

                settings.arkAddress = delegate.address
                settings.publicKey = delegate.publicKey
                
                selfReference.settings = settings
                Settings.saveSettings(settings: settings)
                
                ArkDataManager.shared.updateData()
                ArkActivityView.showSuccessMessage("Settings successfully updated")
                selfReference.navigationController?.popViewController(animated: true)
            } else {
                ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            }
        }
    }
}









