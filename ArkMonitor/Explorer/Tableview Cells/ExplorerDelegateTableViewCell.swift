//
//  ExplorerDelegateTableViewCell.swift
//  Dark
//
//  Created by Andrew on 2017-09-29.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit
import SwiftyArk

class ExplorerDelegateTableViewCell: UITableViewCell {

    public let delegate: Delegate
    
    init(_ delegate: Delegate) {
        self.delegate = delegate
        super.init(style: .default, reuseIdentifier: "delegate")
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle = .none
        
        let nameLabel = UILabel()
        nameLabel.textColor = ArkPalette.highlightedTextColor
        nameLabel.text = delegate.username
        
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 18.0, weight:  .semibold)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(25.0)
            make.right.equalToSuperview().offset(-25.0)
        }
        
        let seperator = UIView()
        seperator.backgroundColor = ArkPalette.backgroundColor
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
