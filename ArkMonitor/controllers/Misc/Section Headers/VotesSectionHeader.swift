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
        
        backgroundColor = UIColor.white
        
        let rankLabel = UILabel()
        rankLabel.textColor = ArkColors.darkGray
        rankLabel.text = "Rank"
        rankLabel.textAlignment = .center
        rankLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(rankLabel)
        
        rankLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        let nameLabel = UILabel()
        nameLabel.textColor = ArkColors.darkGray
        nameLabel.text = "Username"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(rankLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        let addressLabel = UILabel()
        addressLabel.textColor = ArkColors.darkGray
        addressLabel.text = "Address"
        addressLabel.textAlignment = .center
        addressLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(addressLabel)
        
        addressLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(nameLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
