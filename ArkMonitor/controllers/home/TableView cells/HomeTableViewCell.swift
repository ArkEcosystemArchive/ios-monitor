//
//  HomeTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

extension HomeViewController {
class HomeTableViewCell: UITableViewCell {
    
    internal var descriptionLabel : UILabel!
    internal var valueLabel       : ArkCopyableLabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle = .none
        
        descriptionLabel = UILabel()
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = ArkPalette.highlightedTextColor
        descriptionLabel.font = UIFont.systemFont(ofSize: 16.0, weight:  ArkPalette.fontWeight)
        descriptionLabel.adjustsFontSizeToFitWidth = true
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(12.5)
            make.width.equalTo((_screenWidth / 2.0) - 12.5)
        }
        
        valueLabel = ArkCopyableLabel()
        valueLabel.textAlignment = .right
        valueLabel.textColor = ArkPalette.accentColor
        valueLabel.font = UIFont.systemFont(ofSize: 16.0, weight:  ArkPalette.fontWeight)

        addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-12.5)
            make.width.equalTo((_screenWidth / 2.0) - 12.5)
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
}
