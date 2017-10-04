//
//  CurrenctySelectionTableViewCell.swift
//  Dark
//
//  Created by Andrew on 2017-09-23.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit
import SwiftyArk

class CurrenctySelectionTableViewCell: UITableViewCell {
    
    public var currency  : Currency!
    public var nameLabel : UILabel!
    public var checkView : UIImageView!
    
    public func update(_ currency: Currency) {
        self.currency = currency
        let currencyInfo = CurrencyInfo(currency)
        nameLabel.text = currency.rawValue + " - " + currencyInfo.currencyName
    }
    
    public func currencySelected(_ selected: Bool) {
        if selected == true {
            checkView.isHidden = false
        } else {
            checkView.isHidden = true
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "currency")
        
        backgroundColor = ArkPalette.backgroundColor
        selectionStyle = .none
        
        nameLabel = UILabel()
        nameLabel.textColor = ArkPalette.highlightedTextColor
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  .semibold)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(15)
        }
        
        checkView = UIImageView(image: #imageLiteral(resourceName: "check"))
        checkView.isHidden = true
        addSubview(checkView)
        checkView.snp.makeConstraints { (make) in
            make.height.width.equalTo(30.0)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15.0)
        }
        
        
        let seperator = UIView()
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.left.equalTo(15.0)
            make.height.equalTo(1.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
}
