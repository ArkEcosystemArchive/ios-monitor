//
//  DelegateDetailViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-15.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class DelegateDetailViewController: ArkViewController {

    fileprivate let delegate  : Delegate
    fileprivate var tableView : ArkTableView!
    
    init(_ delegate: Delegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = delegate.username
        
        tableView = ArkTableView(frame: CGRect.zero)
        tableView.delegate       = self
        tableView.dataSource     = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override func colorsUpdated() {
        super.colorsUpdated()
        tableView.reloadData()
        tableView.backgroundColor = ArkPalette.backgroundColor
    }
}

// MARK: UITableViewDelegate
extension DelegateDetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
        headerView.backgroundColor = ArkPalette.backgroundColor
        
        let headerLabel = UILabel(frame: CGRect(x: 12.5, y: 0.0, width: _screenWidth - 12.5, height: 40.0))
        headerLabel.textColor = ArkPalette.textColor
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.systemFont(ofSize: 18.0, weight:  ArkPalette.fontWeight)
        
        switch section {
        case 0:
            headerLabel.text = "Address"
        case 1:
            headerLabel.text = "Public Key"
        case 2:
            headerLabel.text = "Votes"
        case 3:
            headerLabel.text = "Produced Blocks"
        case 4:
            headerLabel.text = "Missed Blocks"
        case 5:
            headerLabel.text = "Rank"
        case 6:
            headerLabel.text = "Productivity"
        default:
            headerLabel.text = "Approval"
        }
        headerView.addSubview(headerLabel)
        
        let seperator = UIView(frame: CGRect(x: 0.0, y: 39.5, width: _screenWidth, height: 0.5))
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        
        headerView.addSubview(seperator)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 60.0
        }
        return 40.0
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
}

// MARK: UITableViewDelegate
extension DelegateDetailViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var titleString   = ""
        var numberOfLines = 1
        
        switch indexPath.section {
        case 0:
            titleString = delegate.address
        case 1:
            titleString = delegate.publicKey
            numberOfLines = 2
        case 2:
            if let voteInt = Int64(delegate.vote) {
                titleString = String(Utils.convertToArkBase(value: voteInt))
            } else {
                titleString = delegate.vote
            }
        case 3:
            titleString = String(delegate.producedblocks)
        case 4:
            titleString = String(delegate.missedblocks)
        case 5:
            titleString = String(delegate.rate)
        case 6:
            titleString = String(delegate.productivity) + "%"
        default:
            titleString = String(delegate.approval) + "%"
        }
        
        let cell = TransactionDetailTableViewCell(titleString, numberOfLines: numberOfLines)
        return cell
    }
}

