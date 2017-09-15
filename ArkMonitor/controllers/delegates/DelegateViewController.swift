//
//  DelegateViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class DelegateViewController: ArkViewController {
    
    fileprivate var tableView      : ArkTableView!
    
    fileprivate var delegates        = [Delegate]()
    fileprivate var standByDelegates = [Delegate]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Delegates"

        tableView = ArkTableView(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(delegatesUpdatedNotification), name: NSNotification.Name(rawValue: ArkNotifications.delegatesUpdated.rawValue), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromDataManager()
        loadData()
    }
    
    override func colorsUpdated() {
        super.colorsUpdated()
        tableView.reloadData()
        tableView.backgroundColor = ArkPalette.backgroundColor
    }
    
    @objc private func loadData() {
        ArkDataManager.shared.updateDelegates()
    }
    
    @objc private func delegatesUpdatedNotification() {
        getDataFromDataManager()
    }
    
    private func getDataFromDataManager() {
        delegates        = ArkDataManager.Delegates.delegates
        standByDelegates = ArkDataManager.Delegates.standByDelegates
        tableView.reloadData()
    }

}

// MARK: UITableViewDelegate
extension DelegateViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = DelegateSectionHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let aCell = cell as? DelegateTableViewCell {
            if indexPath.row <= delegates.count - 1 {
                aCell.update(delegates[indexPath.row])
            } else {
                let maxValue = max(0, indexPath.row - delegates.count - 1)
                aCell.update(standByDelegates[maxValue])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? DelegateTableViewCell {
            let vc = DelegateDetailViewController(cell.delegate)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: UITableViewDatasource
extension DelegateViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = delegates.count + standByDelegates.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "delegate")
        
        if cell == nil {
            cell = DelegateTableViewCell(style: .default, reuseIdentifier: "delegate")
        }
        return cell!
    }
    
}




