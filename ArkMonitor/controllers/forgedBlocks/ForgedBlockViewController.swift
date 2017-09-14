//
//  ForgedBlockViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class ForgedBlockViewController: ArkViewController {
    
    fileprivate var tableView      : ArkTableView!
    
    fileprivate var blocks : [Block] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Forged Blocks"

        tableView = ArkTableView(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(forgeBlockUpdateNotification), name: NSNotification.Name(rawValue: ArkNotifications.forgedBlocksUpdated.rawValue), object: nil)
        getDataFromDataManager()
        loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func loadData() {
        ArkDataManager.shared.updateForgedBlocks()
    }
    
    @objc private func forgeBlockUpdateNotification() {
        getDataFromDataManager()
    }
    
    private func getDataFromDataManager() {
        blocks = ArkDataManager.ForgedBlocks.blocks
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegate
extension ForgedBlockViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ForgedBlockSectionHeader(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 35.0))
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let aCell = cell as? ForgedBlockTableViewCell{
            aCell.update(blocks[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

// MARK: UITableViewDatasource
extension ForgedBlockViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "block") as? ForgedBlockTableViewCell
        if cell == nil {
            cell = ForgedBlockTableViewCell(style: .default, reuseIdentifier: "block")
        }
        return cell!
    }
}

