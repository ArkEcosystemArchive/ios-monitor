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
        switch mode {
        case .custom:
            return 40.0
        default:
            switch indexPath.section {
            case 0:
                return 60.0
            default:
                return 40.0
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
}

// MARK: UITableViewDataSource
extension SettingViewController1: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch mode {
            case .custom:
                return 6
            default:
                return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch mode {
        case .custom:
            let cell = UITableViewCell()
            return cell
        default:
            switch indexPath.section {
                case 0:
                    let cell = SettingsUsernameTableViewCell(mode)
                    cell.delegate = self
                    return cell
                default:
                    let cell = UITableViewCell()
                    return cell
            }
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





