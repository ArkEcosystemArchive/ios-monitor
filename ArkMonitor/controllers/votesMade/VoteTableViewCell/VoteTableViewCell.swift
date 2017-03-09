//
//  VoteTableViewCell.swift
//  ArkMonitor
//
//  Created by Victor Lins on 24/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class VoteTableViewCell: BaseTableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override class func height() -> CGFloat {
        return 44
    }
    
    override func setData(_ data: Any?) {
        if let data = data as? Delegate {
            self.rankLabel.text = String(data.rate)
            self.usernameLabel.text = data.username
            self.addressLabel.text = data.address
        }
    }
    
    func setTitles() {
        self.rankLabel.text = "Rank"
        self.usernameLabel.text = "Username"
        self.addressLabel.text = "Address"
    }
}
