//
//  DarkModeTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-15.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

protocol DarkModeTableViewCellDelegate: class {
    func darkModeCell(_ cell: UITableViewCell, didChangeStatus enabled: Bool)
}

class DarkModeTableViewCell: UITableViewCell {
    
    public weak var delegate: DarkModeTableViewCellDelegate?
    
    var nameLabel      : UILabel!
    var darkModeSwitch : UISwitch!
    
    init(_ darkModeOn: Bool) {
        super.init(style: .default, reuseIdentifier: "darkmode")
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle = .none
        
        nameLabel               = UILabel()
        nameLabel.text          = "Dark Mode"
        nameLabel.textColor     = ArkPalette.highlightedTextColor
        nameLabel.textAlignment = .left
        nameLabel.font          = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(25.0)
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        
        darkModeSwitch             = UISwitch()
        darkModeSwitch.onTintColor = ArkPalette.accentColor
        darkModeSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        darkModeSwitch.setOn(darkModeOn, animated: false)
        addSubview(darkModeSwitch)
        darkModeSwitch.snp.makeConstraints { (make) in
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
    
    @objc private func switchValueChanged() {
        delegate?.darkModeCell(self, didChangeStatus: darkModeSwitch.isOn)
       // delegate?.sslCell(self, didChangeStatus: sslSwitch.isOn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

