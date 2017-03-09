//
//  PeersViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 22/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit
import Toaster
import ESPullToRefresh
import NVActivityIndicatorView

class PeersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var peers: [Peer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Peers"
        
        setNavigationBarItem()

        self.tableView.registerCellNib(PeerTableViewCell.self)
        
        _ = self.tableView.es_addPullToRefresh {
            [weak self] in
            
            self?.loadPeers()
            
            self?.tableView.es_stopPullToRefresh()
        }
        
        loadPeers()
    }
    
    func loadPeers() -> Void {
        if (!Reachability.isConnectedToNetwork()) {
            Toast(text: "Please connect to internet.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            
            return
        }
        
        let activityData = ActivityData(type: NVActivityIndicatorType.lineScale)
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        let settings = Settings.getSettings()

        let requestPeers = RequestPeers(myClass: self)
        
        self.peers = []
        self.tableView.reloadData()
        
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
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
        
        func onResponse(object: Any)  -> Void {
            selfReference.peers = object as! [Peer]

            selfReference.peers = selfReference.peers.sorted { $0.state > $1.state }
            
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            selfReference.tableView.reloadData()
        }
    }
 
}


extension PeersViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PeerTableViewCell.height()
    }
    
}

extension PeersViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peers.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PeerTableViewCell.identifier, for: indexPath) as! PeerTableViewCell
        
        if (indexPath.row == 0) {
            cell.setTitles()
        } else {
            cell.setData(self.peers[indexPath.row - 1])
        }
        return cell
    }
    
}
