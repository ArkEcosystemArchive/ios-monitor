//
//  MiscViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class MiscViewController: ArkViewController {
    
    fileprivate var segmentControl : UISegmentedControl!
    fileprivate var tableView      : ArkTableView!
    
    let items = ["Peers", "Votes", "Voters"]
    
    var peers  : [Peer]     = []
    var votes  : [Delegate] = []
    var voters : [Account]  = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = items[0]

        let spacerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 40.0))
        spacerView.backgroundColor = ArkPalette.secondaryBackgroundColor
        
        segmentControl = UISegmentedControl(items: items)
        segmentControl.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        segmentControl.tintColor = ArkPalette.accentColor
        segmentControl.selectedSegmentIndex = 0
        spacerView.addSubview(segmentControl)
        segmentControl.snp.makeConstraints { (make) in
            make.width.equalTo(250.0)
            make.centerX.top.equalToSuperview()
            make.height.equalTo(30.0)
        }
        
        tableView            = ArkTableView(frame: CGRect.zero)
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.tableHeaderView = spacerView
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(miscInfoUpdatedNotification), name: NSNotification.Name(rawValue: ArkNotifications.delegatesUpdated.rawValue), object: nil)
        getDataFromDataManager()
        loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func colorsUpdated() {
        super.colorsUpdated()
        tableView.reloadData()
        tableView.backgroundColor = ArkPalette.backgroundColor
    }
    
    @objc private func loadData() {
        ArkDataManager.shared.updateMisc()
    }
    
    @objc private func miscInfoUpdatedNotification() {
        getDataFromDataManager()
    }
    
    private func getDataFromDataManager() {
        peers = ArkDataManager.Misc.peers
        votes = ArkDataManager.Misc.votes
        voters = ArkDataManager.Misc.voters
        tableView.reloadData()
    }
    
    @objc private func segmentSelected(sender: UISegmentedControl) {
        navigationItem.title = items[sender.selectedSegmentIndex]
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
        return 40.0
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

