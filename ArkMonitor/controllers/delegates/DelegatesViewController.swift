//
//  DelegatesViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 22/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit
import Toaster
import ESPullToRefresh
import NVActivityIndicatorView

class DelegatesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var delegates: [Delegate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Delegates"
        
        setNavigationBarItem()

        self.tableView.registerCellNib(DelegateTableViewCell.self)

        _ = self.tableView.es_addPullToRefresh {
            [weak self] in
            
            self?.loadDelegates()
            
            self?.tableView.es_stopPullToRefresh()
        }

        loadDelegates()
    }
    
    func loadDelegates() -> Void {
        if (!Reachability.isConnectedToNetwork()) {
            Toast(text: "Please connect to internet.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            
            return
        }

        let activityData = ActivityData(type: NVActivityIndicatorType.lineScale)

        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)

        let settings = Settings.getSettings()
        
        let requestActiveDelegates = RequestActiveDelegates(myClass: self)
        let requestStandbyDelegates = RequestActiveDelegates(myClass: self)
        
        self.delegates = []
        self.tableView.reloadData()
        
        ArkService.sharedInstance.requestActiveDelegates(settings: settings, listener: requestActiveDelegates)
        
        ArkService.sharedInstance.requestStandyByDelegates(settings: settings, listener: requestStandbyDelegates)
    }

    private class RequestActiveDelegates: RequestListener {
        let selfReference: DelegatesViewController
        
        init(myClass: DelegatesViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            Toast(text: "Unable to retrieve data. Please try again later.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }

        func onResponse(object: Any)  -> Void {
            selfReference.delegates.append(contentsOf: object as! [Delegate])
            
            selfReference.delegates = selfReference.delegates.sorted { $0.rate < $1.rate }

            if (selfReference.delegates.count > 51) {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                selfReference.tableView.reloadData()
            }
        }
    }

    
    private class RequestStandbyDelegates: RequestListener {
        let selfReference: DelegatesViewController
        
        init(myClass: DelegatesViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            Toast(text: "Unable to retrieve data. Please try again later.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
        
        func onResponse(object: Any)  -> Void {
            selfReference.delegates.append(contentsOf: object as! [Delegate])
            
            selfReference.delegates = selfReference.delegates.sorted { $0.rate < $1.rate }
            
            if (selfReference.delegates.count > 51) {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                selfReference.tableView.reloadData()
            }
        }
    }
}


extension DelegatesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DelegateTableViewCell.height()
    }

}

extension DelegatesViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.delegates.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: DelegateTableViewCell.identifier, for: indexPath) as! DelegateTableViewCell
        if (indexPath.row == 0) {
            cell.setTitles()
        } else {
            cell.setData(self.delegates[indexPath.row - 1])
        }

        return cell
    }
    
}

