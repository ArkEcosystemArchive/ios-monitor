//
//  SettingsTransactionsNotificationTableViewCell.swift
//  Dark
//
//  Created by Andrew on 2017-09-25.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit

class SettingsTransactionsNotificationTableViewCell: UITableViewCell {
    
    var titleLabel          : UILabel!
    var descriptionLabel    : UILabel!
    var notificationSwitch  : UISwitch!

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "account")
        
        backgroundColor = ArkPalette.backgroundColor
        selectionStyle = .none
        titleLabel = UILabel()
        titleLabel.text = "Transaction Notifications"
        titleLabel.textColor = ArkPalette.highlightedTextColor
        titleLabel.font  = UIFont.systemFont(ofSize: 16.0, weight:  .semibold)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10.0)
            make.height.equalTo(20.0)
            make.left.equalTo(15.0)
            make.width.equalTo(250.0)
        }
        
        notificationSwitch             = UISwitch()
        notificationSwitch.onTintColor = ArkPalette.accentColor
        notificationSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        notificationSwitch.isOn = ArkDataManager.showTransactionNotifications
        addSubview(notificationSwitch)
        notificationSwitch.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15.0)
        }
        
        descriptionLabel = UILabel()
        descriptionLabel.text = "If enabled, you will recieve push notifications for new transactions"
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textColor = ArkPalette.textColor
        descriptionLabel.font  = UIFont.systemFont(ofSize: 13.0, weight:  .light)
        descriptionLabel.adjustsFontSizeToFitWidth = true
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview().offset(-5.0)
            make.left.equalTo(15.0)
            make.right.equalTo(notificationSwitch.snp.left).offset(-25.0)
        }
        

        
        let seperator = UIView()
        seperator.backgroundColor = ArkPalette.secondaryBackgroundColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func switchValueChanged() {
        ArkDataManager.showTransactionNotifications = !ArkDataManager.showTransactionNotifications
    }
}

