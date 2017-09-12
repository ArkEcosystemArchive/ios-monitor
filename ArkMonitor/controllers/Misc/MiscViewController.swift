//
//  MiscViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class MiscViewController: UIViewController {
    
    fileprivate var segmentControl : UISegmentedControl!
    fileprivate var tableView      : UITableView!
    fileprivate var refreshControl : UIRefreshControl!
    
    var peers  : [Peer]     = []
    var votes  : [Delegate] = []
    var voters : [Account]  = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = ["Peers", "Votes", "Voters"]
        segmentControl = UISegmentedControl(items: items)
        segmentControl.frame.size = CGSize(width: 250.0, height: 30.0)
        segmentControl.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        navigationItem.titleView = segmentControl
        segmentControl.selectedSegmentIndex = 0
        
        tableView                = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.delegate       = self
        tableView.dataSource     = self
        
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
        
        let requestPeers = RequestPeers(myClass: self)
        ArkService.sharedInstance.requestPeers(settings: settings, listener: requestPeers)
        
        let requestVotes = RequestVotes(myClass: self)
        ArkService.sharedInstance.requestVotes(settings: settings, listener: requestVotes)
        
        let requestVoters = RequestVoters(myClass: self)
        ArkService.sharedInstance.requestVoters(settings: settings, listener: requestVoters)
    }
    
    private class RequestPeers: RequestListener {
        let selfReference: MiscViewController
        
        init(myClass: MiscViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            selfReference.refreshControl.endRefreshing()
        }
        
        func onResponse(object: Any)  -> Void {
            selfReference.peers = object as! [Peer]
            selfReference.peers = selfReference.peers.sorted { $0.status > $1.status }
            
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
            selfReference.tableView.reloadData()
        }
    }
    
    private class RequestVotes: RequestListener {
        let selfReference: MiscViewController
        
        init(myClass: MiscViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            selfReference.refreshControl.endRefreshing()
        }
        
        func onResponse(object: Any)  -> Void {
            let votes = object as! Votes
            
            selfReference.votes = votes.delegates
            selfReference.votes = selfReference.votes.sorted { $0.rate < $1.rate }
            
            selfReference.refreshControl.endRefreshing()
            selfReference.tableView.reloadData()
        }
    }
    
    private class RequestVoters: RequestListener {
        let selfReference: MiscViewController
        
        init(myClass: MiscViewController) {
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            selfReference.refreshControl.endRefreshing()
        }
        
        func onResponse(object: Any)  -> Void {
            let votes = object as! Voters
            
            selfReference.voters = votes.accounts
            selfReference.voters = selfReference.voters.sorted { $0.balance > $1.balance }
            
            selfReference.refreshControl.endRefreshing()
            selfReference.tableView.reloadData()
        }
    }
    
    @objc private func segmentSelected(sender: UISegmentedControl) {
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegate
extension MiscViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            let header = PeerSectionHeader(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
            return header
        case 1:
            let header = VotesSectionHeader(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
            return header
        default:
            let header = VotersSectionHeader(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let aCell = cell as? PeerTableViewCell {
            aCell.update(peers[indexPath.row])
        }
        
        if let aCell = cell as? VotesTableViewCell {
            aCell.update(votes[indexPath.row])
        }
        
        if let aCell = cell as? VotersTableViewCell {
            aCell.update(voters[indexPath.row])
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
extension MiscViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return peers.count
        case 1:
            return votes.count
        default:
            return voters.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            var cell = tableView.dequeueReusableCell(withIdentifier: "peer") as? PeerTableViewCell
            if cell == nil {
                cell = PeerTableViewCell(style: .default, reuseIdentifier: "peer")
            }
            return cell!
        case 1:
            var cell = tableView.dequeueReusableCell(withIdentifier: "votes") as? VotesTableViewCell
            if cell == nil {
                cell = VotesTableViewCell(style: .default, reuseIdentifier: "votes")
            }
            return cell!
        default:
            var cell = tableView.dequeueReusableCell(withIdentifier: "voters") as? VotersTableViewCell
            if cell == nil {
                cell = VotersTableViewCell(style: .default, reuseIdentifier: "voters")
            }
            return cell!
        }
    }
}

