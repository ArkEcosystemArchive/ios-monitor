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
    fileprivate var currentCustom : CustomServer?
    fileprivate var currentMode   : Server = .arkNet1
    fileprivate var username      : String = ""

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
        customServers = ArkCustomServerManager.CustomServers
        
        if let currentCustomServer  = ArkCustomServerManager.CurrentCustomServer {
            if settings.serverType == .custom {
                self.currentCustom = currentCustomServer
            } else {
                ArkCustomServerManager.CurrentCustomServer = nil
            }
        }
        loadSettings()
    }
    
    override func colorsUpdated() {
        super.colorsUpdated()
        tableview.reloadData()
        tableview.backgroundColor = ArkPalette.backgroundColor
    }
    
    private func loadSettings() {
        settings    = Settings.getSettings()
        currentMode = settings.serverType
        username    = settings.username
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
            return 65
        }
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
        headerView.backgroundColor = ArkPalette.backgroundColor
        
        let headerLabel       = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
        headerLabel.font      = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SettingSelectionPresetTableViewCell {
            changeServerToPreset(cell.mode)
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? SettingSelectionCustomTableViewCell {
            changeServerToCustom(cell.server)
        }
        
        if let _ = tableView.cellForRow(at: indexPath) as? SettingsSelectionAddServerTableViewCell {
            let customServerVC = SettingsCustomServerViewController()
            navigationController?.pushViewController(customServerVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let aCell = cell as? SettingsSelectionUsernameTableViewCell {
            aCell.update(username)
        }
        
        if let aCell = cell as? SettingSelectionPresetTableViewCell {
            if aCell.mode == currentMode {
                aCell.setServerSelction(true)
            } else {
                aCell.setServerSelction(false)
            }
        }
        
        if let aCell = cell as? SettingSelectionCustomTableViewCell {
            if let currentCustomServer = self.currentCustom {
                if currentCustomServer == aCell.server {
                    aCell.setServerSelction(true)
                } else {
                    aCell.setServerSelction(false)
                }
            } else {
                aCell.setServerSelction(false)
            }
        }
    }
    
    private func updateServer() {
        if currentMode == .custom {
            
        } else {
            updatePreset()
        }
    }
    
    private func changeServerToPreset(_ mode: Server) {
        guard mode != currentMode else {
            return
        }
        
        currentMode = mode
        updatePreset()
    }
    
    private func changeServerToCustom(_ server: CustomServer) {
        currentMode = .custom
        guard server != currentCustom else {
            return
        }
        
        currentCustom = server
        ArkCustomServerManager.CurrentCustomServer = server
        updateCustom()
    }
    
    private func updatePreset() {
        tableview.reloadData()
        
        view.endEditing(true)
        
        guard Reachability.isConnectedToNetwork() == true else {
            ArkActivityView.showMessage("Please connect to internet.")
            return
        }
        
        let settings = Settings()
        
        if (!Utils.validateUsername(username: username)) {
            ArkActivityView.showMessage("Username invalid.")
            return
        }

        settings.setServerType(serverType: currentMode)
        settings.username = username
        ArkService.sharedInstance.requestDelegate(settings: settings, listener: RequestData(myClass: self))
    }
    
    private func updateCustom() {
        tableview.reloadData()
        view.endEditing(true)
        
        guard Reachability.isConnectedToNetwork() == true else {
            ArkActivityView.showMessage("Please connect to internet.")
            return
        }
        
        guard let server = currentCustom else {
            ArkActivityView.showMessage("Error configuring server")
            return
        }
        
        let settings = Settings()
        
        if (!Utils.validateUsername(username: username)) {
            ArkActivityView.showMessage("Username invalid.")
            return
        }
        
        settings.username   = username
        settings.ipAddress  = server.ipAddress
        settings.port       = server.port
        settings.sslEnabled = server.isSSL
        
        settings.setServerType(serverType: currentMode)
        ArkService.sharedInstance.requestDelegate(settings: settings, listener: RequestData(myClass: self))
    }
}

// MARK: RequestData
extension SettingSelectionViewController {
    
    private class RequestData: RequestListener {
        let selfReference: SettingSelectionViewController
        
        init(myClass: SettingSelectionViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkDataManager.shared.updateData()
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
        }
        
        func onResponse(object: Any)  -> Void {
            
            if let delegate = object as? Delegate {
                let settings = Settings.getSettings()
                
                if selfReference.currentMode != .custom {
                    settings.username = selfReference.username
                    settings.setServerType(serverType: selfReference.currentMode)
                    settings.arkAddress = delegate.address
                    settings.publicKey = delegate.publicKey
                    selfReference.settings = settings
                    Settings.saveSettings(settings: settings)
                    ArkDataManager.shared.updateData()
                    ArkCustomServerManager.CurrentCustomServer = nil
                    selfReference.currentCustom = nil
                    ArkActivityView.showSuccessMessage("Settings successfully updated")
                } else {
                    guard let currentServer = selfReference.currentCustom else {
                        ArkActivityView.showMessage("Failed to find custom server")
                        return
                    }
                    settings.username = selfReference.username
                    settings.sslEnabled = currentServer.isSSL
                    settings.setServerType(serverType: selfReference.currentMode)
                    settings.ipAddress = currentServer.ipAddress
                    settings.port = currentServer.port
                    settings.arkAddress = delegate.address
                    settings.publicKey = delegate.publicKey
                    selfReference.settings = settings
                    Settings.saveSettings(settings: settings)
                    ArkDataManager.shared.updateData()
                    ArkActivityView.showSuccessMessage("Settings successfully updated")
                }
            } else {
                ArkActivityView.showMessage("Error configuring server")
            }
        }
    }
}


// MARK: UITableViewDataSource
extension SettingSelectionViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let cell = tableView.cellForRow(at: indexPath) as? SettingSelectionCustomTableViewCell else {
            return false
        }
        
        if cell.server == currentCustom {
            return false
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "delete") { (action, index) in
            
            guard let cell = tableView.cellForRow(at: indexPath) as? SettingSelectionCustomTableViewCell else {
                return
            }
            
            self.customServers.remove(object: cell.server)
            ArkCustomServerManager.remove(cell.server)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        delete.backgroundColor = ArkPalette.accentColor
        return [delete]
    }
    
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
            cell.delegate = self
            return cell
        } else {
            let totalRow = tableView.numberOfRows(inSection: indexPath.section)
            if indexPath.row == totalRow - 1 {
                let cell = SettingsSelectionAddServerTableViewCell(style: .default, reuseIdentifier: "addCustomServer")
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
                    let cell = SettingSelectionCustomTableViewCell(customServers[indexPath.row - 2])
                    return cell
                }
            }
        }
    }
}

// MARK: SettingsSelectionUsernameTableViewCellDelegate
extension SettingSelectionViewController : SettingsSelectionUsernameTableViewCellDelegate {
    
    func usernameCell(_ cell: SettingsSelectionUsernameTableViewCell, didChangeText text: String?) {
        if let name = text {
            username = name
        }
    }
    
    func usernameCell(_ cell: SettingsSelectionUsernameTableViewCell, didFinishEditing text: String?) {
        if let name = text {
            username = name
        }
        updateServer()
    }
    

}

