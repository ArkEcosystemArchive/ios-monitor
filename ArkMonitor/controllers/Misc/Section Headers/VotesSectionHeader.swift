//
//  VotesSectionHeader.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class VotesSectionHeader: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ArkPalette.backgroundColor

        let rankLabel = UILabel()
        rankLabel.textColor = ArkPalette.textColor
        rankLabel.text = "Rank"
        rankLabel.textAlignment = .center
        rankLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        addSubview(rankLabel)
        
        rankLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3.0)
        }
        
        let nameLabel = UILabel()
        nameLabel.textColor = ArkPalette.textColor
        nameLabel.text = "Username"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(rankLabel.snp.right)
            make.width.equalToSuperview().dividedBy(3.0)
        }
        
        let addressLabel = UILabel()
        addressLabel.textColor = ArkPalette.textColor
        addressLabel.text = "Address"
        addressLabel.textAlignment = .center
        addressLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        addSubview(addressLabel)
        
        addressLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(nameLabel.snp.right)
            make.width.equalToSuperview().dividedBy(3.0)
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
