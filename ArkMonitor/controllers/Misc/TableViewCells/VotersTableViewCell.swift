//
//  VotersTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class VotersTableViewCell: UITableViewCell {

    var usernameLabel : UILabel!
    var balanceLabel  : UILabel!
    var addressLabel  : UILabel!
    var seperator    : UIView!

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle  = .none
        
        usernameLabel = UILabel()
        usernameLabel.textColor = ArkPalette.highlightedTextColor
        usernameLabel.textAlignment = .center
        usernameLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)
        addSubview(usernameLabel)
        
        usernameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo((_screenWidth / 3.0) - 10.0)
            make.centerX.equalTo(_screenWidth / 6.0)
        }
        
        addressLabel = UILabel()
        addressLabel.textColor = ArkPalette.highlightedTextColor
        addressLabel.textAlignment = .center
        addressLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)
        addSubview(addressLabel)
        
        addressLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo((_screenWidth / 3.0) - 10.0)
            make.centerX.equalTo(_screenWidth / 2.0)
        }
        
        balanceLabel = UILabel()
        balanceLabel.textColor = ArkPalette.highlightedTextColor
        balanceLabel.textAlignment = .center
        balanceLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)
        addSubview(balanceLabel)
        
        balanceLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo((_screenWidth / 3.0) - 10.0)
            make.centerX.equalTo(_screenWidth * 5.0 / 6.0)
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
    
    public func update(_ voters: Account) {
        usernameLabel.text = voters.username
        addressLabel.text  = voters.address
        balanceLabel.text  = String(Utils.convertToArkBase(value: voters.balance))
        
        usernameLabel.textColor = ArkPalette.highlightedTextColor
        addressLabel.textColor = ArkPalette.highlightedTextColor
        balanceLabel.textColor = ArkPalette.highlightedTextColor
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor

        backgroundColor = ArkPalette.secondaryBackgroundColor

        
        usernameLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)
        addressLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)
        balanceLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)
    }
}
