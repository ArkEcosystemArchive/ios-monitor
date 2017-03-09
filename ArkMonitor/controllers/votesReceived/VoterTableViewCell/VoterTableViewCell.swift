//
//  VoterTableViewCell.swift
//  ArkMonitor
//
//  Created by Victor Lins on 24/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class VoterTableViewCell: BaseTableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    override class func height() -> CGFloat {
        return 44
    }

    override func setData(_ data: Any?) {
        if let data = data as? Account {
            self.usernameLabel.text = data.username
            self.addressLabel.text = data.address
            self.balanceLabel.text = String(Utils.convertToArkBase(value: data.balance))
        }
    }
    
    func setTitles() {
        self.usernameLabel.text = "Username"
        self.addressLabel.text = "Address"
        self.balanceLabel.text = "Balance"
    }
}
