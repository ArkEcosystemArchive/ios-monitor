//
//  ForgedBlockSectionHeader.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class ForgedBlockSectionHeader: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        
        let heightLabel = UILabel()
        heightLabel.textColor = ArkPalette.tertiaryBackgroundColor
        heightLabel.text = "Height"
        heightLabel.textAlignment = .center
        heightLabel.font = UIFont.systemFont(ofSize: 15.0)
        addSubview(heightLabel)
        
        heightLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        let timeLabel = UILabel()
        timeLabel.textColor = ArkPalette.tertiaryBackgroundColor
        timeLabel.text = "Time"
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.systemFont(ofSize: 15.0)
        addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(heightLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        let feeLabel = UILabel()
        feeLabel.textColor = ArkPalette.tertiaryBackgroundColor
        feeLabel.text = "Fee"
        feeLabel.textAlignment = .center
        feeLabel.font = UIFont.systemFont(ofSize: 15.0)
        addSubview(feeLabel)
        
        feeLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(timeLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        let rewardLabel = UILabel()
        rewardLabel.textColor = ArkPalette.tertiaryBackgroundColor
        rewardLabel.text = "Reward"
        rewardLabel.textAlignment = .center
        rewardLabel.font = UIFont.systemFont(ofSize: 15.0)
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
}
