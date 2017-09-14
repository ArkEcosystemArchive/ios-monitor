//
//  SettingsSelectionAddServerTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-14.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class SettingsSelectionAddServerTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "addServer")
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle = .none
        
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = "Add custom server"
        nameLabel.textColor = ArkPalette.textColor
        nameLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .light)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(12.5)
        }
        

        let seperator = UIView()
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
}
