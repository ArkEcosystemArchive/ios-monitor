//
//  DelegateListViewController.swift
//  Dark
//
//  Created by Andrew on 2017-09-22.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit
import SwiftyArk

class DelegateListViewController: ArkViewController {
    
    fileprivate var tableView : ArkTableView!
    fileprivate var delegates = [Delegate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Delegates"
        tableView            = ArkTableView(CGRect.zero)
        tableView.delegate   = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateDelegates), name: NSNotification.Name(rawValue: ArkNotifications.delegateListUpdated.rawValue), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        updateDelegates()
    }
    
    @objc private func updateDelegates() {
        guard let currentDelegates = ArkDataManager.currentDelegates else {
            return
        }
        self.delegates = currentDelegates
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegate
extension DelegateListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = DelegateListSectionHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 35.0))
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let aCell = cell as? DelegateTableViewCell {
            aCell.update(delegates[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DelegateDetailViewController(delegates[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: UITableViewDatasource
extension DelegateListViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = delegates.count
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
