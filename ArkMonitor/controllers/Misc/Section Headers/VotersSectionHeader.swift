//
//  VotersSectionHeader.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class VotersSectionHeader: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ArkPalette.backgroundColor

        let usernameLabel = UILabel()
        usernameLabel.textColor = ArkPalette.highlightedTextColor
        usernameLabel.text = "Username"
        usernameLabel.textAlignment = .center
        usernameLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(usernameLabel)
        
        usernameLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3.0)
        }
        
        let addressLabel = UILabel()
        addressLabel.textColor = ArkPalette.highlightedTextColor
        addressLabel.text = "Address"
        addressLabel.textAlignment = .center
        addressLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(addressLabel)
        
        addressLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(usernameLabel.snp.right)
            make.width.equalToSuperview().dividedBy(3.0)
        }
        
        let balanceLabel = UILabel()
        balanceLabel.textColor = ArkPalette.highlightedTextColor
        balanceLabel.text = "Balance"
        balanceLabel.textAlignment = .center
        balanceLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(balanceLabel)
        
        balanceLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(addressLabel.snp.right)
            make.width.equalToSuperview().dividedBy(3.0)
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
