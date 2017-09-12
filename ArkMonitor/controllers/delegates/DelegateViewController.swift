//
//  DelegateViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class DelegateViewController: UIViewController {
    
    fileprivate var tableView      : UITableView!
    fileprivate var refreshControl : UIRefreshControl!
    
    fileprivate var delegates        = [Delegate]()
    fileprivate var standByDelegates = [Delegate]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView          = UIImageView(image: #imageLiteral(resourceName: "whiteLogo"))
        
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
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
        let requestActiveDelegates = RequestActiveDelegates(myClass: self)
        let requestStandbyDelegates = RequestStandbyDelegates(myClass: self)

        let settings = Settings.getSettings()
        ArkService.sharedInstance.requestActiveDelegates(settings: settings, listener: requestActiveDelegates)
        ArkService.sharedInstance.requestStandyByDelegates(settings: settings, listener: requestStandbyDelegates)
    }
    
    private class RequestActiveDelegates: RequestListener {
        let selfReference: DelegateViewController
        
        init(myClass: DelegateViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            selfReference.refreshControl.endRefreshing()
        }
        
        func onResponse(object: Any)  -> Void {
            var currentDelegates = object as! [Delegate]
            currentDelegates.sort { $0.rate < $1.rate }
            selfReference.delegates = currentDelegates
            selfReference.refreshControl.endRefreshing()
            selfReference.tableView.reloadData()
        }
    }
    
    
    private class RequestStandbyDelegates: RequestListener {
        let selfReference: DelegateViewController
        
        init(myClass: DelegateViewController){
            selfReference = myClass
        }
        
        public func onFailure(e: Error) -> Void {
            ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
            selfReference.refreshControl.endRefreshing()
        }
        
        func onResponse(object: Any)  -> Void {
            var currentDelegates = object as! [Delegate]
            currentDelegates.sort { $0.rate < $1.rate }
            selfReference.standByDelegates = currentDelegates
            selfReference.refreshControl.endRefreshing()
            selfReference.tableView.reloadData()
        }
    }
}

// MARK: UITableViewDelegate
extension DelegateViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = DelegateSectionHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
        return header
    }
}

// MARK: UITableViewDatasource
extension DelegateViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = delegates.count + standByDelegates.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
}




