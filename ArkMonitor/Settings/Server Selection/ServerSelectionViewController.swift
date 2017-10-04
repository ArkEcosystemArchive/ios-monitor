//
//  ServerSelectionViewController.swift
//  Dark
//
//  Created by Andrew on 2017-09-26.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit

class ServerSelectionViewController: ArkViewController {

    fileprivate var tableView    : ArkTableView!
    fileprivate var customServers =  [CustomServer]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Server"
        
        tableView = ArkTableView(CGRect.zero)
        tableView.delegate       = self
        tableView.dataSource     = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        customServers = ArkNetworkManager.CustomServers
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customServers = ArkNetworkManager.CustomServers
        tableView.reloadData()
    }
}

extension ServerSelectionViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let currentCell = cell as? SettingSelectionPresetTableViewCell {
            if currentCell.mode == ArkNetworkManager.currentNetwork {
                currentCell.setServerSelction(true)
            } else {
                currentCell.setServerSelction(false)
            }
        }
        
        if let currentCell = cell as? SettingSelectionCustomTableViewCell {
            if currentCell.server == ArkNetworkManager.CurrentCustomServer {
                currentCell.setServerSelction(true)
            } else {
                currentCell.setServerSelction(false)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if let cell = tableView.cellForRow(at: indexPath) as? SettingSelectionPresetTableViewCell {
            ArkNetworkManager.updateNetwork(cell.mode)
            tableView.reloadData()
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? SettingSelectionCustomTableViewCell {
            ArkNetworkManager.updateNetwork(cell.server)
            tableView.reloadData()
        }
        
        if let _ = tableView.cellForRow(at: indexPath) as? SettingsSelectionAddServerTableViewCell {
            let customServerVC = SettingsCustomServerViewController()
            navigationController?.pushViewController(customServerVC, animated: true)
        }
    }
}

extension ServerSelectionViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 + customServers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let totalRow = tableView.numberOfRows(inSection: indexPath.section)
        if indexPath.row == totalRow - 1 {
            let cell = SettingsSelectionAddServerTableViewCell(style: .default, reuseIdentifier: "addCustomServer")
            return cell
        }  else {
            switch indexPath.row {
            case 0:
                let cell = SettingSelectionPresetTableViewCell(.arknode)
                return cell
            case 1:
                let cell = SettingSelectionPresetTableViewCell(.arknet1)
                return cell
            case 2:
                let cell = SettingSelectionPresetTableViewCell(.arknet2)
                return cell
            default:
                let cell = SettingSelectionCustomTableViewCell(customServers[indexPath.row - 3])
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let cell = tableView.cellForRow(at: indexPath) as? SettingSelectionCustomTableViewCell else {
            return false
        }
        
        if cell.isCurrentServer == true {
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
            ArkNetworkManager.remove(cell.server)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            ArkActivityView.showMessage("Successfully removed server", style: .success)
        }
        
        delete.backgroundColor = ArkPalette.accentColor
        return [delete]
    }
}
