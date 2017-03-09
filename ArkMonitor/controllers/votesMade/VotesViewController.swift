//
//  VotesViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 24/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit
import Toaster
import ESPullToRefresh
import NVActivityIndicatorView

class VotesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var delegates : [Delegate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Votes"
        
        setNavigationBarItem()
        
        self.tableView.registerCellNib(VoteTableViewCell.self)
        
        _ = self.tableView.es_addPullToRefresh {
            [weak self] in
            
            self?.loadVotes()
            
            self?.tableView.es_stopPullToRefresh()
        }
        
        loadVotes()
    }
    
    func loadVotes() -> Void {
        if (!Reachability.isConnectedToNetwork()) {
            Toast(text: "Please connect to internet.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            
            return
        }
        
        let activityData = ActivityData(type: NVActivityIndicatorType.lineScale)
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        let settings = Settings.getSettings()

        let requestVotes = RequestVotes(myClass: self)
        
        self.delegates = []
        self.tableView.reloadData()
        
        ArkService.sharedInstance.requestVotes(settings: settings, listener: requestVotes)
    }
    
    private class RequestVotes: RequestListener {
        let selfReference: VotesViewController
        
        init(myClass: VotesViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            Toast(text: "Unable to retrieve data. Please try again later.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
        
        func onResponse(object: Any)  -> Void {
            let votes = object as! Votes
            
            selfReference.delegates = votes.delegates
            
            selfReference.delegates = selfReference.delegates.sorted { $0.rate < $1.rate }
            
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            selfReference.tableView.reloadData()
        }
    }
    
}

extension VotesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return VoteTableViewCell.height()
    }
    
}

extension VotesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.delegates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: VoteTableViewCell.identifier, for: indexPath) as! VoteTableViewCell
        
        if (indexPath.row == 0) {
            cell.setTitles()
        } else {
            cell.setData(self.delegates[indexPath.row - 1])
        }
        return cell
    }
    
}
