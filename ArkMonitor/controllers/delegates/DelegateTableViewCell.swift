//
//  DelegateTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class DelegateTableViewCell: UITableViewCell {
    
    var delegate = Delegate()
    
    var rankLabel         : UILabel!
    var nameLabel         : UILabel!
    var approvalLabel     : UILabel!
    var productivityLabel : UILabel!
    var seperator         : UIView!
    
    public func update(_ delegate: Delegate) {
        self.delegate          = delegate
        rankLabel.text         = String(delegate.rate)
        nameLabel.text         = delegate.username
        approvalLabel.text     = String(delegate.approval) + "%"
        productivityLabel.text = String(delegate.productivity) + "%"
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor

        if ArkDataManager.Home.delegate.username == delegate.username {
            rankLabel.textColor         = ArkPalette.accentColor
            nameLabel.textColor         = ArkPalette.accentColor
            approvalLabel.textColor     = ArkPalette.accentColor
            productivityLabel.textColor = ArkPalette.accentColor
            rankLabel.font              = UIFont.systemFont(ofSize: 15.0, weight:  ArkPalette.fontWeight)
            nameLabel.font              = UIFont.systemFont(ofSize: 15.0, weight:  ArkPalette.fontWeight)
            approvalLabel.font          = UIFont.systemFont(ofSize: 15.0, weight:  ArkPalette.fontWeight)
            productivityLabel.font      = UIFont.systemFont(ofSize: 15.0, weight:  ArkPalette.fontWeight)
        } else {
            rankLabel.textColor         = ArkPalette.accentColor
            nameLabel.textColor         = ArkPalette.highlightedTextColor
            approvalLabel.textColor     = ArkPalette.highlightedTextColor
            productivityLabel.textColor = ArkPalette.highlightedTextColor
            rankLabel.font              = UIFont.systemFont(ofSize: 15.0, weight:  ArkPalette.fontWeight)
            nameLabel.font              = UIFont.systemFont(ofSize: 15.0, weight:  ArkPalette.fontWeight)
            approvalLabel.font          = UIFont.systemFont(ofSize: 15.0, weight:  ArkPalette.fontWeight)
            productivityLabel.font      = UIFont.systemFont(ofSize: 15.0, weight:  ArkPalette.fontWeight)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle = .none
        
        rankLabel = UILabel()
        rankLabel.textColor = ArkPalette.accentColor
        rankLabel.textAlignment = .center
        rankLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  ArkPalette.fontWeight)
        addSubview(rankLabel)
        
        rankLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.16)
        }
        
        nameLabel = UILabel()
        nameLabel.textColor = ArkPalette.highlightedTextColor
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  ArkPalette.fontWeight)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(rankLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.28)
        }
        
        approvalLabel = UILabel()
        approvalLabel.textColor = ArkPalette.highlightedTextColor
        approvalLabel.textAlignment = .center
        approvalLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  ArkPalette.fontWeight)
        addSubview(approvalLabel)
        
        approvalLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(nameLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.28)
        }
        
        productivityLabel = UILabel()
        productivityLabel.textColor = ArkPalette.highlightedTextColor
        productivityLabel.textAlignment = .center
        productivityLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  ArkPalette.fontWeight)
        addSubview(productivityLabel)
        
        productivityLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(approvalLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.28)
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
}
