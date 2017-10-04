//
//  ExplorerTransactionTableViewCell.swift
//  Dark
//
//  Created by Andrew on 2017-09-29.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit
import SwiftyArk

class ExplorerTransactionTableViewCell: UITableViewCell {
    
    public let transaction: Transaction
    
    init(_ transaction: Transaction) {
        self.transaction = transaction
        super.init(style: .default, reuseIdentifier: "transaction")
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle = .none
        
        let nameLabel = UILabel()
        nameLabel.textColor = ArkPalette.highlightedTextColor
        nameLabel.text = transaction.id
        
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 2
        nameLabel.font = UIFont.systemFont(ofSize: 16.0, weight:  .semibold)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(12.5)
            make.right.equalToSuperview().offset(-12.5)
        }
        
        let seperator = UIView()
        seperator.backgroundColor = ArkPalette.backgroundColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
