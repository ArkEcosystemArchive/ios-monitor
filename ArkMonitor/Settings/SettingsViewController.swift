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

class SettingsViewController: ArkViewController {

    fileprivate var tableView : ArkTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("TabBar.Settings", comment: "")
        
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
