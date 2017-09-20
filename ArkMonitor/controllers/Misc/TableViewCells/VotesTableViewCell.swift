//
//  VotesTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class VotesTableViewCell: UITableViewCell {

    var rankLabel    : UILabel!
    var nameLabel    : UILabel!
    var addressLabel : UILabel!
    var seperator    : UIView!
    var vote = Delegate()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle  = .none
        
        rankLabel = UILabel()
        rankLabel.textColor = ArkPalette.highlightedTextColor
        rankLabel.textAlignment = .center
        rankLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)
        addSubview(rankLabel)
        
        rankLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo((_screenWidth / 3.0) - 10.0)
            make.centerX.equalTo(_screenWidth / 6.0)
        }
        
        nameLabel = UILabel()
        nameLabel.textColor = ArkPalette.highlightedTextColor
        nameLabel.textAlignment = .center
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo((_screenWidth / 3.0) - 10.0)
            make.centerX.equalTo(_screenWidth / 2.0)
        }
        
        addressLabel = UILabel()
        addressLabel.textColor = ArkPalette.highlightedTextColor
        addressLabel.textAlignment = .center
        addressLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)
        addSubview(addressLabel)
        
        addressLabel.snp.makeConstraints { (make) in
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
    
    public func update(_ votes: Delegate) {
        self.vote        = votes
        rankLabel.text    = String(votes.rate)
        nameLabel.text    = votes.username
        addressLabel.text = votes.address
        
        rankLabel.textColor = ArkPalette.highlightedTextColor
        nameLabel.textColor = ArkPalette.highlightedTextColor
        addressLabel.textColor = ArkPalette.highlightedTextColor
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor

        backgroundColor = ArkPalette.secondaryBackgroundColor

        rankLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)
        nameLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)
        addressLabel.font = UIFont.systemFont(ofSize: 14.0, weight:  ArkPalette.fontWeight)
        
    }
}
