//
//  VotesViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 24/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit
import Toaster

class VotesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var refreshControl: UIRefreshControl!
    
    var delegates : [Delegate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Votes"
        
        setNavigationBarItem()
        
        tableView.registerCellNib(VoteTableViewCell.self)
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(updateTableView), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        loadVotes(true)
    }
    
    func loadVotes(_ animated: Bool) -> Void {
        guard Reachability.isConnectedToNetwork() == true else {
            
            Toast(text: "Please connect to internet.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            return
        }
        
        ArkActivityView.startAnimating()
        
        let settings = Settings.getSettings()

        let requestVotes = RequestVotes(myClass: self)
        
        delegates = []
        tableView.reloadData()
        
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
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
        }
        
        func onResponse(object: Any)  -> Void {
            let votes = object as! Votes
            
            selfReference.delegates = votes.delegates
            
            selfReference.delegates = selfReference.delegates.sorted { $0.rate < $1.rate }
            
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
            selfReference.tableView.reloadData()
        }
    }
    
    @objc private func updateTableView() {
        loadVotes(false)
    }
}

extension VotesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return VoteTableViewCell.height()
    }
    
}

extension VotesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: VoteTableViewCell.identifier, for: indexPath) as! VoteTableViewCell
        
        if (indexPath.row == 0) {
            cell.setTitles()
        } else {
            cell.setData(delegates[indexPath.row - 1])
        }
        return cell
    }
    
}
