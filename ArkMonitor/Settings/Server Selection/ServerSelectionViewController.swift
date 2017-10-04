// Copyright (c) 2016 Ark
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
