//
//  SettingSelectionCustomTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-14.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class SettingSelectionCustomTableViewCell: UITableViewCell {
    
    public  let server    : CustomServer
    private var nameLabel : UILabel!
    private var check     : UIImageView!
    
    init(_ server: CustomServer) {
        self.server = server
        super.init(style: .default, reuseIdentifier: "customServer")
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle = .none
        
        nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = server.name
        nameLabel.textColor = ArkPalette.highlightedTextColor
        nameLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(12.5)
        }

        let checkImage = #imageLiteral(resourceName: "serverCheck")
        check = UIImageView()
        check.image = checkImage.maskWithColor(color: ArkPalette.accentColor)
        check.isHidden = true
        
        addSubview(check)
        check.snp.makeConstraints { (make) in
            make.height.width.equalTo(25.0)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12.5)
        }
        
        let seperator = UIView()
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    public func setServerSelction(_ isCurrentServer: Bool) {
        let checkImage = #imageLiteral(resourceName: "serverCheck")
        check.image = checkImage.maskWithColor(color: ArkPalette.accentColor)
        if isCurrentServer == true {
            nameLabel.textColor = ArkPalette.highlightedTextColor
            check.isHidden = false
        } else {
            nameLabel.textColor = ArkPalette.highlightedTextColor
            check.isHidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
