//
//  LatestTransactionTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class LatestTransactionTableViewCell: UITableViewCell {
    
    var timeLabel : UILabel!
    var idLabel   : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white
        selectionStyle  = .none
        
        timeLabel = UILabel()
        timeLabel.textColor = ArkColors.gray
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        idLabel = UILabel()
        idLabel.textColor = ArkColors.blue
        idLabel.textAlignment = .center
        idLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(idLabel)
        
        idLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(timeLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.45)
        }
        
        let spacer = UIView()
        addSubview(spacer)
        spacer.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
        }
        
        let chevron = UIImageView(image: #imageLiteral(resourceName: "chevron"))
        spacer.addSubview(chevron)
        chevron.snp.makeConstraints { (make) in
            make.height.width.equalTo(20.0)
            make.center.greaterThanOrEqualToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(_ transaction: Transaction) {
        idLabel.text   = transaction.id
        timeLabel.text = Utils.getTimeAgo(timestamp: Double(transaction.timestamp))
    }
}
