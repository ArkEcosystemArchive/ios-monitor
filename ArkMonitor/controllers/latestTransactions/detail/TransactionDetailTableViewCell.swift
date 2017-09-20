//
//  TransactionDetailTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class TransactionDetailTableViewCell: UITableViewCell {
    
    var titleLabel: ArkCopyableLabel!
    
    init(_ title: String, numberOfLines: Int) {
        super.init(style: .default, reuseIdentifier: "detail")
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle  = .none
        
        titleLabel               = ArkCopyableLabel()
        titleLabel.text          = title
        titleLabel.textColor     = ArkPalette.accentColor
        titleLabel.font          = UIFont.systemFont(ofSize: 15.0, weight:  ArkPalette.fontWeight)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = numberOfLines
        titleLabel.adjustsFontSizeToFitWidth = true
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-12.5)
            make.left.equalTo(12.5)
        }
        
        let seperator = UIView()
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
}
