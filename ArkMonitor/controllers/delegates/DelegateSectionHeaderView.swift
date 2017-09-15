//
//  DelegateSectionHeaderView.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class DelegateSectionHeaderView: UIView {
    
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
            make.width.equalToSuperview().multipliedBy(0.16)
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
            make.width.equalToSuperview().multipliedBy(0.28)
        }
        
        let approvalLabel = UILabel()
        approvalLabel.textColor = ArkPalette.textColor
        approvalLabel.text = "Approval"
        approvalLabel.textAlignment = .center
        approvalLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        addSubview(approvalLabel)
        
        approvalLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(nameLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.28)
        }
        
        let productivityLabel = UILabel()
        productivityLabel.textColor = ArkPalette.textColor
        productivityLabel.text = "Productivity"
        productivityLabel.textAlignment = .center
        productivityLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        addSubview(productivityLabel)
        
        productivityLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(approvalLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.28)
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
