//
//  TransactionTableViewCell.swift
//  ArkMonitor
//
//  Created by Victor Lins on 24/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class TransactionTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var transactionIdLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var ammountLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var confirmationsLabel: UILabel!
    
    override class func height() -> CGFloat {
        return 191
    }

    override func setData(_ data: Any?) {
        if let data = data as? Transaction {
            transactionIdLabel.text = data.id
            timeLabel.text = Utils.getTimeAgo(timestamp: Double(data.timestamp))
            fromLabel.text = data.senderId
            toLabel.text = data.recipientId
            ammountLabel.text = String(Utils.convertToArkBase(value: data.amount))
            feeLabel.text = String(Utils.convertToArkBase(value: Int64(data.fee)))
            confirmationsLabel.text = String(data.confirmations)
        }
    }
}
