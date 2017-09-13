//
//  SettingViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-13.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

internal enum ServerMode {
    case node1
    case node2
    case custom
}

class SettingViewController1: UIViewController {
    
    fileprivate var tableview: ArkTableView!
    fileprivate var mode : ServerMode = .node1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview = ArkTableView(frame: CGRect.zero)
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

// MARK: UITableViewDelegate
extension SettingViewController1: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 60.0
        case 1:
            return 125.0
        case 2:
            if mode == .custom {
                return 60.0
            } else {
                return 0.0
            }
        case 5:
            return 60.0
        default:
            if mode == .custom {
                return 40.0
            } else {
                return 0.0
            }
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
        if let aCell = cell as? SettingsServerTableViewCell {
            aCell.updateMode(mode)
        }
    }
}

// MARK: UITableViewDataSource
extension SettingViewController1: UITableViewDataSource {
    
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
extension SettingViewController1: SettingsUsernameTableViewCellDelegate {
    func usernameCell(_ cell: SettingsUsernameTableViewCell, didChangeText text: String?) {
        if let aText = text {
            print(aText)
        } else {
            print("Blank")
        }
    }
}

// MARK: SettingsServerTableViewCellDelegate
extension SettingViewController1: SettingsServerTableViewCellDelegate {
    func serverCell(_ cell: SettingsServerTableViewCell, didChangeMode mode: ServerMode) {
        self.mode = mode
        tableview.reloadData()
    }
}

// MARK: SettingsSaveTableViewCellDelegate
extension SettingViewController1: SettingsSaveTableViewCellDelegate {
    func saveCellButtonWasTapped(_ cell: SettingsSaveTableViewCell) {
        print("Save Button Tapped")
    }
}

// MARK: SettingsIPTableViewCellDelegate
extension SettingViewController1 : SettingsIPTableViewCellDelegate {
    func ipCell(_ cell: SettingsIPTableViewCell, didChangeText text: String?) {
        print("IP Address updated")
    }
}






