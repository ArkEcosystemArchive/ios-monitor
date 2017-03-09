//
//  VotersViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 24/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit
import Toaster
import ESPullToRefresh
import NVActivityIndicatorView

class VotersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var accounts : [Account] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Voters"
        
        setNavigationBarItem()
        
        self.tableView.registerCellNib(VoterTableViewCell.self)
        
        _ = self.tableView.es_addPullToRefresh {
            [weak self] in
            
            self?.loadVoters()
            
            self?.tableView.es_stopPullToRefresh()
        }
        
        loadVoters()
    }
    
    func loadVoters() -> Void {
        if (!Reachability.isConnectedToNetwork()) {
            Toast(text: "Please connect to internet.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            
            return
        }
        
        let activityData = ActivityData(type: NVActivityIndicatorType.lineScale)
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        let settings = Settings.getSettings()

        let requestVoters = RequestVoters(myClass: self)
        
        self.accounts = []
        self.tableView.reloadData()
        
        ArkService.sharedInstance.requestVoters(settings: settings, listener: requestVoters)
    }
    
    private class RequestVoters: RequestListener {
        let selfReference: VotersViewController
        
        init(myClass: VotersViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            Toast(text: "Unable to retrieve data. Please try again later.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
        
        func onResponse(object: Any)  -> Void {
            let votes = object as! Voters
            
            selfReference.accounts = votes.accounts
            
            selfReference.accounts = selfReference.accounts.sorted { $0.balance > $1.balance }
            
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            selfReference.tableView.reloadData()
        }
    }
    
}

extension VotersViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return VoterTableViewCell.height()
    }
    
}

extension VotersViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accounts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: VoterTableViewCell.identifier, for: indexPath) as! VoterTableViewCell
        
        if (indexPath.row == 0) {
            cell.setTitles()
        } else {
            cell.setData(self.accounts[indexPath.row - 1])
        }
        return cell
    }
    
}
