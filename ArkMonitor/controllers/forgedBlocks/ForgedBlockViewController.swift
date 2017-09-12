//
//  ForgedBlockViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class ForgedBlockViewController: UIViewController {
    
    fileprivate var tableView      : UITableView!
    fileprivate var refreshControl : UIRefreshControl!
    
    fileprivate var blocks : [Block] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "whiteLogo"))
        
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = ArkColors.blue
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        loadData()
    }
    
    @objc private func loadData() {
        let settings = Settings.getSettings()
        let requestBlocks = RequestBlocks(myClass: self)
        ArkService.sharedInstance.requestBlocks(settings: settings, listener: requestBlocks)
    }
    
    private class RequestBlocks: RequestListener {
        let selfReference: ForgedBlockViewController
        
        init(myClass: ForgedBlockViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            selfReference.refreshControl.endRefreshing()
        }
        
        func onResponse(object: Any)  -> Void {
            let blocks = object as! [Block]
            
            selfReference.blocks = blocks
            selfReference.refreshControl.endRefreshing()
            selfReference.tableView.reloadData()
        }
    }
}

// MARK: UITableViewDelegate
extension ForgedBlockViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ForgedBlockSectionHeader(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
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

