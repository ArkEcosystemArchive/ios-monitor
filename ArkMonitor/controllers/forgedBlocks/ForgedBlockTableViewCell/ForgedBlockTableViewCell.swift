//
//  ForgedBlockTableViewCell.swift
//  ArkMonitor
//
//  Created by Victor Lins on 25/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class ForgedBlockTableViewCell: BaseTableViewCell {
    @IBOutlet weak var heightLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var feeLabel: UILabel!

    @IBOutlet weak var rewardLabel: UILabel!
    
    override class func height() -> CGFloat {
        return 44
    }
    
    override func setData(_ data: Any?) {
        if let data = data as? Block {
            self.heightLabel.text = String(data.height)
            self.timeLabel.text = Utils.getTimeAgo(timestamp: Double(data.timestamp))
            self.feeLabel.text = String(Utils.convertToArkBase(value: Int64(data.totalFee)))
            self.rewardLabel.text = String(Utils.convertToArkBase(value: Int64(data.reward)))
        }
    }
    
    func setTitles() {
        self.heightLabel.text = "Height"
        self.timeLabel.text = "Time"
        self.feeLabel.text = "Fee"
        self.rewardLabel.text = "Reward"
    }
    
}
