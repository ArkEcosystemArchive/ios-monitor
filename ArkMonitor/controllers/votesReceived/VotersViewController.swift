//
//  VotersViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 24/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit
import Toaster

class VotersViewController: UIViewController {

    @IBOutlet weak var tableView   : UITableView!
    fileprivate var refreshControl : UIRefreshControl!

    var accounts : [Account] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Voters"
        
        setNavigationBarItem()
        
        tableView.registerCellNib(VoterTableViewCell.self)
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(updateTableView), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        loadVoters(true)
    }
    
    func loadVoters(_ animated: Bool) -> Void {
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

        let requestVoters = RequestVoters(myClass: self)
        
        accounts = []
        tableView.reloadData()
        
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
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
        }
        
        func onResponse(object: Any)  -> Void {
            let votes = object as! Voters
            
            selfReference.accounts = votes.accounts
            
            selfReference.accounts = selfReference.accounts.sorted { $0.balance > $1.balance }
            
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
            selfReference.tableView.reloadData()
        }
    }
    
    @objc private func updateTableView() {
        loadVoters(false)
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
            cell.setData(accounts[indexPath.row - 1])
        }
        return cell
    }
    
}
