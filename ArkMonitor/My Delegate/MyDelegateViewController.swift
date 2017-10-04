//
//  MyDelegateViewController.swift
//  Dark
//
//  Created by Andrew on 2017-09-23.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit
import SwiftyArk

class MyDelegateViewController: ArkViewController {

    public var delegate       : Delegate?
    fileprivate var tableView : ArkTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myDelegate = ArkDataManager.currentVote {
            delegate = myDelegate
        }
        
        navigationItem.title = delegate?.username ?? "Delegate"
        
        tableView = ArkTableView(CGRect.zero)
        tableView.delegate       = self
        tableView.dataSource     = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let myDelegate = ArkDataManager.currentVote {
            delegate = myDelegate
        } else {
            delegate = nil
            ArkActivityView.showMessage("No delegate vote found for Account", style: .warning)
        }
        tableView.reloadData()
        navigationItem.title = delegate?.username ?? "Delegate"
    }
}

// MARK: UITableViewDelegate
extension MyDelegateViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 35.0))
        headerView.backgroundColor = ArkPalette.secondaryBackgroundColor
        
        let headerLabel = UILabel(frame: CGRect(x: 12.5, y: 0.0, width: _screenWidth - 12.5, height: 35.0))
        headerLabel.textColor = ArkPalette.highlightedTextColor
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  .semibold)
        
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
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 65.0
        }
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
}

// MARK: UITableViewDelegate
extension MyDelegateViewController : UITableViewDataSource {
    
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
            titleString = delegate?.address ?? ""
        case 1:
            titleString = delegate?.publicKey ?? ""
            numberOfLines = 2
        case 2:
            titleString = String(delegate?.votes ?? 0.0)
        case 3:
            titleString = String(delegate?.producedblocks ?? 0)
        case 4:
            titleString = String(delegate?.missedblocks ?? 0)
        case 5:
            titleString = String(delegate?.rate ?? 0)
        case 6:
            titleString = String(delegate?.productivity ?? 0.0) + "%"
        default:
            titleString = String(delegate?.approval ?? 0.0) + "%"
        }
        
        let cell = ArkDetailTableViewCell(titleString, numberOfLines: numberOfLines)
        return cell
    }
}

