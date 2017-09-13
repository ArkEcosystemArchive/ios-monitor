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
        
        backgroundColor = UIColor.white
        
        let rankLabel = UILabel()
        rankLabel.textColor = ArkColors.darkGray
        rankLabel.text = "Rank"
        rankLabel.textAlignment = .center
        rankLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(rankLabel)
        
        rankLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.16)
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
            make.width.equalToSuperview().multipliedBy(0.28)
        }
        
        let approvalLabel = UILabel()
        approvalLabel.textColor = ArkColors.darkGray
        approvalLabel.text = "Approval"
        approvalLabel.textAlignment = .center
        approvalLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(approvalLabel)
        
        approvalLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(nameLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.28)
        }
        
        let productivityLabel = UILabel()
        productivityLabel.textColor = ArkColors.darkGray
        productivityLabel.text = "Productivity"
        productivityLabel.textAlignment = .center
        productivityLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(productivityLabel)
        
        productivityLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(approvalLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.28)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
