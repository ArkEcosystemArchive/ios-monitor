//
//  SettingSelectionTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-14.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class SettingSelectionTableViewCell: UITableViewCell {
    
    public let mode: Server
    
    init(_ mode: Server) {
        self.mode = mode
        super.init(style: .default, reuseIdentifier: "presetServer")
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle = .none
        
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = ArkPalette.textColor
        nameLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .light)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(12.5)
        }
        
        switch mode {
        case .arkNet1:
            nameLabel.text = "node1.arknet.cloud"
        default:
            nameLabel.text = "node2.arknet.cloud"
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
