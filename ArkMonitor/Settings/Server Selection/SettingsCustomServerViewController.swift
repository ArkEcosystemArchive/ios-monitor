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

class SettingsCustomServerViewController: ArkViewController {
    
    fileprivate var tableview     : ArkTableView!
    
    fileprivate var serverName : String?
    fileprivate var ipAddress  : String?
    fileprivate var port       : Int?
    fileprivate var isSSL      = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Custom"
        tableview            = ArkTableView(CGRect.zero)
        tableview.delegate   = self
        tableview.dataSource = self
        
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
        return CGFloat.leastNormalMagnitude
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 0, 1, 2, 3:
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = SettingsServerNameTableViewCell(reuseIdentifier: "cell")
            cell.delegate = self
            return cell
        case 1:
            let cell = SettingsIPTableViewCell(reuseIdentifier: "cell")
            cell.delegate = self
            return cell
        case 2:
            let cell = SettingsPortTableViewCell(reuseIdentifier: "cell")
            cell.delegate = self
            return cell
        case 3:
            let cell = SettingsSSLTableViewCell(reuseIdentifier: "cell")
            cell.delegate = self
            return cell
        default:
            let cell = SettingsSaveTableViewCell(reuseIdentifier: "cell")
            cell.delegate = self
            return cell
        }
    }
}

// MARK: SettingsServerNameTableViewCellDelegate
extension SettingsCustomServerViewController : SettingsServerNameTableViewCellDelegate {
    func ipCell(_ cell: SettingsServerNameTableViewCell, didChangeText text: String?) {
        self.serverName = text
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
        
        guard let currentServerName = serverName else {
            ArkActivityView.showMessage("Server name cannot be blank", style: .warning)
            return
        }
        
        guard let ip = ipAddress else {
            ArkActivityView.showMessage("IP Address cannot be blank", style: .warning)
            return
        }
        
        guard let currentPort = port else {
            ArkActivityView.showMessage("Port cannot be blank", style: .warning)
            return
        }
        
        let newCustomServer = CustomServer(currentServerName, ipAddress: ip, port: currentPort, isSSL: isSSL)
        
        ArkNetworkManager.add(newCustomServer) { (success) in
            if success == true {
                ArkActivityView.showMessage("Successfully added server", style: .success)
                self.navigationController?.popViewController(animated: true)
            } else {
                ArkActivityView.showMessage("Server already exists with that name", style: .warning)
                return
            }
        }
    }
}




