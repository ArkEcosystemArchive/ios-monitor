//
//  LatestTransactionsSectionHeaderView.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class LatestTransactionsSectionHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ArkPalette.backgroundColor
        
        let timeLabel = UILabel()
        timeLabel.textColor = ArkPalette.textColor
        timeLabel.textAlignment = .center
        timeLabel.text = "Time"
        timeLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  ArkPalette.fontWeight)
        addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        let idLabel = UILabel()
        idLabel.textColor = ArkPalette.textColor
        idLabel.textAlignment = .center
        idLabel.text = "Transaction Id"
        idLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  ArkPalette.fontWeight)
        addSubview(idLabel)
        
        idLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(timeLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        let seperator = UIView()
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        let seperator2 = UIView()
        seperator2.backgroundColor = ArkPalette.tertiaryBackgroundColor
        addSubview(seperator2)
        seperator2.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
