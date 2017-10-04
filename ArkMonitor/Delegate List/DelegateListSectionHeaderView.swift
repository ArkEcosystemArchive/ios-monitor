//
//  DelegateListSectionHeaderView.swift
//  Dark
//
//  Created by Andrew on 2017-09-22.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit

class DelegateListSectionHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        
        let rankLabel = UILabel()
        rankLabel.textColor = ArkPalette.highlightedTextColor
        rankLabel.text = "Rank"
        rankLabel.textAlignment = .center
        rankLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  .semibold)
        addSubview(rankLabel)
        
        rankLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.16)
        }
        
        let nameLabel = UILabel()
        nameLabel.textColor = ArkPalette.highlightedTextColor
        nameLabel.text = "Username"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  .semibold)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(rankLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.28)
        }
        
        let approvalLabel = UILabel()
        approvalLabel.textColor = ArkPalette.highlightedTextColor
        approvalLabel.text = "Approval"
        approvalLabel.textAlignment = .center
        approvalLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  .semibold)
        addSubview(approvalLabel)
        
        approvalLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(nameLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.28)
        }
        
        let productivityLabel = UILabel()
        productivityLabel.textColor = ArkPalette.highlightedTextColor
        productivityLabel.text = "Productivity"
        productivityLabel.textAlignment = .center
        productivityLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  .semibold)
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
