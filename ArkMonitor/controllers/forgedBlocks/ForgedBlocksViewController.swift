//
//  ForgedBlocksViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 22/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit
import Toaster
import NVActivityIndicatorView

class ForgedBlocksViewController: UIViewController {
    
    @IBOutlet weak var tableView   : UITableView!
    fileprivate var refreshControl : UIRefreshControl!

    var blocks : [Block] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Forged Blocks"
        
        setNavigationBarItem()
        
        tableView.registerCellNib(ForgedBlockTableViewCell.self)
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(updateTableView), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        loadBlocks()
    }
    
    private func loadBlocks() -> Void {
        
        guard Reachability.isConnectedToNetwork() == true else {
            Toast(text: "Please connect to internet.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            return
        }

        let activityData = ActivityData(type: NVActivityIndicatorType.lineScale)
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        let settings = Settings.getSettings()

        let requestBlocks = RequestBlocks(myClass: self)
        
        blocks = []
        tableView.reloadData()
        
        ArkService.sharedInstance.requestBlocks(settings: settings, listener: requestBlocks)
    }
    
    private class RequestBlocks: RequestListener {
        let selfReference: ForgedBlocksViewController
        
        init(myClass: ForgedBlocksViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            Toast(text: "Unable to retrieve data. Please try again later.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
        
        func onResponse(object: Any)  -> Void {
            let blocks = object as! [Block]
            
            selfReference.blocks = blocks
            
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            selfReference.tableView.reloadData()
        }
    }
    
    @objc private func updateTableView() {
        loadBlocks()
        
        refreshControl.endRefreshing()
    }
}

extension ForgedBlocksViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ForgedBlockTableViewCell.height()
    }
    
}

extension ForgedBlocksViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blocks.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ForgedBlockTableViewCell.identifier, for: indexPath) as! ForgedBlockTableViewCell
        
        if (indexPath.row == 0) {
            cell.setTitles()
        } else {
            cell.setData(blocks[indexPath.row - 1])
        }
        return cell
    }
    
}
