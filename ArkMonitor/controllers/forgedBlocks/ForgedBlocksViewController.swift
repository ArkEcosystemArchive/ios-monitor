//
//  ForgedBlocksViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 22/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit
import Toaster
import ESPullToRefresh
import NVActivityIndicatorView

class ForgedBlocksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var blocks : [Block] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Forged Blocks"
        
        setNavigationBarItem()
        
        self.tableView.registerCellNib(ForgedBlockTableViewCell.self)
        
        _ = self.tableView.es_addPullToRefresh {
            [weak self] in
            
            self?.loadBlocks()
            
            self?.tableView.es_stopPullToRefresh()
        }
        
        loadBlocks()
    }
    
    func loadBlocks() -> Void {
        if (!Reachability.isConnectedToNetwork()) {
            Toast(text: "Please connect to internet.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            
            return
        }
        
        let activityData = ActivityData(type: NVActivityIndicatorType.lineScale)
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        let settings = Settings.getSettings()

        let requestBlocks = RequestBlocks(myClass: self)
        
        self.blocks = []
        self.tableView.reloadData()
        
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
    
}

extension ForgedBlocksViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ForgedBlockTableViewCell.height()
    }
    
}

extension ForgedBlocksViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blocks.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ForgedBlockTableViewCell.identifier, for: indexPath) as! ForgedBlockTableViewCell
        
        if (indexPath.row == 0) {
            cell.setTitles()
        } else {
            cell.setData(self.blocks[indexPath.row - 1])
        }
        return cell
    }
    
}
