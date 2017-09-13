//
//  ForgedBlockTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class ForgedBlockTableViewCell: UITableViewCell {
    
    var heightLabel  : UILabel!
    var timeLabel   : UILabel!
    var feeLabel    : UILabel!
    var rewardLabel : UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white
        selectionStyle  = .none
        
        heightLabel = UILabel()
        heightLabel.textColor = ArkColors.gray
        heightLabel.textAlignment = .center
        heightLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(heightLabel)
        
        heightLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        timeLabel = UILabel()
        timeLabel.textColor = ArkColors.gray
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(heightLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        feeLabel = UILabel()
        feeLabel.textColor = ArkColors.blue
        feeLabel.textAlignment = .center
        feeLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(feeLabel)
        
        feeLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(timeLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        rewardLabel = UILabel()
        rewardLabel.textColor = ArkColors.blue
        rewardLabel.textAlignment = .center
        rewardLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(rewardLabel)
        
        rewardLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(feeLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(_ block: Block) {
        heightLabel.text = String(block.height)
        timeLabel.text   = Utils.getTimeAgo(timestamp: Double(block.timestamp))
        feeLabel.text    = String(Utils.convertToArkBase(value: Int64(block.totalFee)))
        rewardLabel.text = String(Utils.convertToArkBase(value: Int64(block.reward)))
    }
}
