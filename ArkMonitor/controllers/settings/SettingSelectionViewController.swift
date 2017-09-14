//
//  SettingSelectionViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-14.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class SettingSelectionViewController: ArkViewController {
    
    fileprivate var tableView : ArkTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Server"
        tableView            = ArkTableView(frame: CGRect.zero)
        tableView.delegate   = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

// MARK: UITableViewDelegate
extension SettingSelectionViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
        headerView.backgroundColor = ArkPalette.backgroundColor
        
        let headerLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
        headerLabel.font = UIFont.systemFont(ofSize: 18.0)
        headerLabel.textColor = ArkPalette.textColor
        headerLabel.textAlignment = .center
        
        headerLabel.text = "Select Server"

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
}


// MARK: UITableViewDataSource
extension SettingSelectionViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = SettingSelectionTableViewCell(.arkNet1)
            return cell
        case 1:
            let cell = SettingSelectionTableViewCell(.arkNet2)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}
