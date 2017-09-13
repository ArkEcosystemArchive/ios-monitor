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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white
        selectionStyle  = .none
        
        usernameLabel = UILabel()
        usernameLabel.textColor = ArkColors.gray
        usernameLabel.textAlignment = .center
        usernameLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(usernameLabel)
        
        usernameLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3.0)
        }
        
        addressLabel = UILabel()
        addressLabel.textColor = ArkColors.gray
        addressLabel.textAlignment = .center
        addressLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(addressLabel)
        
        addressLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(usernameLabel.snp.right)
            make.width.equalToSuperview().dividedBy(3.0)
        }
        
        balanceLabel = UILabel()
        balanceLabel.textColor = ArkColors.blue
        balanceLabel.textAlignment = .center
        balanceLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(balanceLabel)
        
        balanceLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(addressLabel.snp.right)
            make.width.equalToSuperview().dividedBy(3.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(_ voters: Account) {
        usernameLabel.text = voters.username
        addressLabel.text  = voters.address
        balanceLabel.text  = String(Utils.convertToArkBase(value: voters.balance))
    }
}
