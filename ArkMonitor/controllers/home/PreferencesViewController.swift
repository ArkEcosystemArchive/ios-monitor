//
//  PreferencesViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-15.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class PreferencesViewController: ArkViewController {
    
    fileprivate var tableView : ArkTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Preferences"
        
        tableView = ArkTableView(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    override func colorsUpdated() {
        super.colorsUpdated()
        tableView.reloadData()
        tableView.backgroundColor = ArkPalette.backgroundColor
    }
}

// MARK: UITableViewDelegate
extension PreferencesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
        headerView.backgroundColor = ArkPalette.backgroundColor
        
        let headerLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
        headerLabel.font = UIFont.systemFont(ofSize: 18.0, weight:  ArkPalette.fontWeight)
        headerLabel.textColor = ArkPalette.textColor
        headerLabel.textAlignment = .center
        headerLabel.text = "User Interface"
        headerView.addSubview(headerLabel)
        
        let seperator2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 0.5))
        seperator2.backgroundColor = ArkPalette.tertiaryBackgroundColor
        headerView.addSubview(seperator2)
        
        let seperator = UIView(frame: CGRect(x: 0.0, y: 39.5, width: _screenWidth, height: 0.5))
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        
        headerView.addSubview(seperator)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

// MARK: UITableViewDataSource
extension PreferencesViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DarkModeTableViewCell(isDarkMode)
        cell.delegate = self
        return cell
    }
}

// MARK: DarkModeTableViewCellDelegate
extension PreferencesViewController : DarkModeTableViewCellDelegate {
    
    func darkModeCell(_ cell: UITableViewCell, didChangeStatus enabled: Bool) {
        isDarkMode = enabled
    }
}

