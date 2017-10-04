//
//  BlockDetailViewController.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-15.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class BlockDetailViewController: ArkViewController {
    
    fileprivate let block     : Block
    fileprivate var tableView : ArkTableView!
    
    init(_ block: Block) {
        self.block = block
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title     = "Detail"
        tableView                = ArkTableView(frame: CGRect.zero)
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
extension BlockDetailViewController : UITableViewDelegate {
    
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
            headerLabel.text = "Block ID"
            let seperator2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 0.5))
            seperator2.backgroundColor = ArkPalette.tertiaryBackgroundColor
            headerView.addSubview(seperator2)
        case 1:
            headerLabel.text = "Height"
        case 2:
            headerLabel.text = "Previous Block"
        case 3:
            headerLabel.text = "Number of Transactions"
        case 4:
            headerLabel.text = "Total Amount"
        case 5:
            headerLabel.text = "Total Fee"
        case 6:
            headerLabel.text = "Rewards Fee"
        case 7:
            headerLabel.text = "Payload Length"
        case 8:
            headerLabel.text = "Generator Public Key"
        case 9:
            headerLabel.text = "Block Signature"
        default:
            headerLabel.text = "Confirmations"
        }
        headerView.addSubview(headerLabel)
        
        let seperator = UIView(frame: CGRect(x: 0.0, y: 39.5, width: _screenWidth, height: 0.5))
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        
        headerView.addSubview(seperator)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 8  {
            return 60.0
        } else if indexPath.section == 9 {
            return 90.0
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
extension BlockDetailViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var titleString   = ""
        var numberOfLines = 1
        
        switch indexPath.section {
        case 0:
            titleString = String(block.id)
        case 1:
            titleString = String(block.height)
        case 2:
            titleString = block.previousBlock
        case 3:
            titleString = String(block.numberOfTransactions)
        case 4:
            titleString = String(Utils.convertToArkBase(value: Int64(block.totalAmount)))
        case 5:
            titleString = String(Utils.convertToArkBase(value: Int64(block.totalFee)))
        case 6:
            titleString = String(Utils.convertToArkBase(value: Int64(block.reward)))
        case 7:
            titleString = String(block.payloadLength)
        case 8:
            titleString   = block.generatorPublicKey
            numberOfLines = 2
        case 9:
            titleString = block.blockSignature
            numberOfLines = 4
        default:
            titleString = String(block.confirmations)
        }
        let cell = BlockDetailTableViewCell(titleString, numberOfLines: numberOfLines)
        return cell
    }
}
