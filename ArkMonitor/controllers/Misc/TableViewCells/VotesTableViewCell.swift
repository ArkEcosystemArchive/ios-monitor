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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle  = .none
        
        rankLabel = UILabel()
        rankLabel.textColor = ArkPalette.textColor
        rankLabel.textAlignment = .center
        rankLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        addSubview(rankLabel)
        
        rankLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        nameLabel = UILabel()
        nameLabel.textColor = ArkPalette.textColor
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(rankLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        addressLabel = UILabel()
        addressLabel.textColor = ArkPalette.textColor
        addressLabel.textAlignment = .center
        addressLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        addSubview(addressLabel)
        
        addressLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(nameLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.4)
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
        rankLabel.text    = String(votes.rate)
        nameLabel.text    = votes.username
        addressLabel.text = votes.address
    }
}
