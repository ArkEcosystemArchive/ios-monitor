//
//  LatestTransactionTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class LatestTransactionTableViewCell: UITableViewCell {
    
    var timeLabel : UILabel!
    var idLabel   : UILabel!
    var seperator : UIView!

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle  = .none
        
        timeLabel = UILabel()
        timeLabel.textColor = ArkPalette.highlightedTextColor
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)
        addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        idLabel = UILabel()
        idLabel.textColor = ArkPalette.accentColor
        idLabel.textAlignment = .center
        idLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)
        addSubview(idLabel)
        
        idLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(timeLabel.snp.right)
            make.right.equalToSuperview().offset(-12.5)
        }
        
        seperator = UIView()
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(_ transaction: Transaction) {
        idLabel.text   = transaction.id
        timeLabel.text = Utils.getTimeAgo(timestamp: Double(transaction.timestamp))
        
        backgroundColor     = ArkPalette.secondaryBackgroundColor
        timeLabel.textColor = ArkPalette.highlightedTextColor
        idLabel.textColor  = ArkPalette.accentColor
        
        timeLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)
        idLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)

        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
    }
}
