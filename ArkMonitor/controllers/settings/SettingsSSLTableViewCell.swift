//
//  SettingsSSLTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-13.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

protocol SettingsSSLTableViewCellDelegate: class {
    func sslCell(_ cell: SettingsSSLTableViewCell, didChangeStatus enabled: Bool)
}

class SettingsSSLTableViewCell: UITableViewCell {
    
    public weak var delegate: SettingsSSLTableViewCellDelegate?
    
    var nameLabel  : UILabel!
    var sslSwitch  : UISwitch!
    
    init(_ mode: Server) {
        super.init(style: .default, reuseIdentifier: "port")
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle = .none
        
        
        nameLabel               = UILabel()
        nameLabel.text          = "SSL Enabled?"
        nameLabel.textColor     = ArkPalette.highlightedTextColor
        nameLabel.textAlignment = .left
        nameLabel.font          = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(25.0)
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        
        sslSwitch             = UISwitch()
        sslSwitch.onTintColor = ArkPalette.accentColor
        sslSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        addSubview(sslSwitch)
        sslSwitch.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-25.0)
        }
        
        let seperator = UIView()
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    public func update(_ enabled: Bool) {
        sslSwitch.setOn(enabled, animated: false)
    }
    
    @objc private func switchValueChanged() {
        delegate?.sslCell(self, didChangeStatus: sslSwitch.isOn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



