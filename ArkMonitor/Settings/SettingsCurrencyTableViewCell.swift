//
//  SettingsCurrencyTableViewCell.swift
//  Dark
//
//  Created by Andrew on 2017-09-23.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit
import SwiftyArk

class SettingsCurrencyTableViewCell: UITableViewCell {
    
    var titleLabel    : UILabel!
    var currencyLabel : UILabel!
    
    init(_ currency: Currency) {
        super.init(style: .default, reuseIdentifier: "currency")
        
        backgroundColor = ArkPalette.backgroundColor
        selectionStyle = .none
        titleLabel = UILabel()
        titleLabel.text = "Reference Currency"
        titleLabel.textColor = ArkPalette.highlightedTextColor
        titleLabel.font  = UIFont.systemFont(ofSize: 16.0, weight:  .semibold)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(15.0)
            make.width.equalTo(250.0)
        }
        
        let chevron = UIImageView(image: #imageLiteral(resourceName: "chevron"))
        addSubview(chevron)
        chevron.snp.makeConstraints { (make) in
            make.height.width.equalTo(15.0)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15.0)
        }
        
        currencyLabel = UILabel()
        currencyLabel.textAlignment = .right
        currencyLabel.text = currency.rawValue
        currencyLabel.textColor = ArkPalette.textColor
        currencyLabel.font = UIFont.systemFont(ofSize: 18.0, weight:  .regular)
        addSubview(currencyLabel)
        currencyLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(100.0)
            make.right.equalTo(chevron.snp.left).offset(-10.0)


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
}
