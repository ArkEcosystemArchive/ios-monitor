//
//  DelegatesViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 22/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class DelegatesViewController: UIViewController {

    @IBOutlet weak var tableView   : UITableView!
    fileprivate var refreshControl : UIRefreshControl!

    var delegates: [Delegate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Delegates"
        
        setNavigationBarItem()

        tableView.registerCellNib(DelegateTableViewCell.self)
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(updateTableView), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }

        loadDelegates(true)
    }
    
    func loadDelegates(_ animated: Bool) -> Void {
        guard Reachability.isConnectedToNetwork() == true else {
            ArkActivityView.showMessage("Please connect to internet.")
            return
        }
        
        if animated == true {
            ArkActivityView.startAnimating()
        }

        let settings = Settings.getSettings()
        
        let requestActiveDelegates = RequestActiveDelegates(myClass: self)
        let requestStandbyDelegates = RequestActiveDelegates(myClass: self)
        
        delegates = []
        tableView.reloadData()
        
        ArkService.sharedInstance.requestActiveDelegates(settings: settings, listener: requestActiveDelegates)
        
        ArkService.sharedInstance.requestStandyByDelegates(settings: settings, listener: requestStandbyDelegates)
    }

    private class RequestActiveDelegates: RequestListener {
        let selfReference: DelegatesViewController
        
        init(myClass: DelegatesViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
        }

        func onResponse(object: Any)  -> Void {
            selfReference.delegates.append(contentsOf: object as! [Delegate])
            
            selfReference.delegates = selfReference.delegates.sorted { $0.rate < $1.rate }

            if (selfReference.delegates.count > 51) {
                ArkActivityView.stopAnimating()
                selfReference.tableView.reloadData()
                selfReference.refreshControl.endRefreshing()
            }
        }
    }

    
    private class RequestStandbyDelegates: RequestListener {
        let selfReference: DelegatesViewController
        
        init(myClass: DelegatesViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            ArkActivityView.stopAnimating()
            selfReference.refreshControl.endRefreshing()
        }
        
        func onResponse(object: Any)  -> Void {
            selfReference.delegates.append(contentsOf: object as! [Delegate])
            
            selfReference.delegates = selfReference.delegates.sorted { $0.rate < $1.rate }
            
            if (selfReference.delegates.count > 51) {
                ArkActivityView.stopAnimating()
                selfReference.refreshControl.endRefreshing()
                selfReference.tableView.reloadData()
            }
        }
    }
    
    @objc private func updateTableView() {
        loadDelegates(false)
    }
}


extension DelegatesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DelegateTableViewCell.height()
    }

}

extension DelegatesViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegates.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: DelegateTableViewCell.identifier, for: indexPath) as! DelegateTableViewCell
        if (indexPath.row == 0) {
            cell.setTitles()
        } else {
            cell.setData(delegates[indexPath.row - 1])
        }

        return cell
    }
    
}

