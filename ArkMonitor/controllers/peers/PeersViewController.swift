//
//  PeersViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 22/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit
import Toaster

class PeersViewController: UIViewController {
    
    @IBOutlet weak var tableView   : UITableView!
    fileprivate var refreshControl : UIRefreshControl!
    
    var peers: [Peer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Peers"
        
        setNavigationBarItem()

        tableView.registerCellNib(PeerTableViewCell.self)
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(updateTableView), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        loadPeers(true)
    }
    
    func loadPeers(_ animated: Bool) -> Void {
        guard Reachability.isConnectedToNetwork() == true else {
            
            Toast(text: "Please connect to internet.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            return
        }
        
        if animated == true {
            ArkActivityView.startAnimating()
        }
        
        let settings = Settings.getSettings()

        let requestPeers = RequestPeers(myClass: self)
        
        peers = []
        tableView.reloadData()
        
        ArkService.sharedInstance.requestPeers(settings: settings, listener: requestPeers)
    }
    
    private class RequestPeers: RequestListener {
        let selfReference: PeersViewController
        
        init(myClass: PeersViewController){
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
            selfReference.peers = object as! [Peer]

            selfReference.peers = selfReference.peers.sorted { $0.status > $1.status }
            
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
            selfReference.tableView.reloadData()
        }
    }
    
    @objc private func updateTableView() {
        loadPeers(false)
    }
}


extension PeersViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PeerTableViewCell.height()
    }
    
}

extension PeersViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peers.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PeerTableViewCell.identifier, for: indexPath) as! PeerTableViewCell
        
        if (indexPath.row == 0) {
            cell.setTitles()
        } else {
            cell.setData(peers[indexPath.row - 1])
        }
        return cell
    }
    
}
