//
//  ArkDetailTableViewCell.swift
//  Dark
//
//  Created by Andrew on 2017-09-22.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit

class ArkDetailTableViewCell: UITableViewCell {
    
    var titleLabel: ArkCopyableLabel!
    
    init(_ title: String, numberOfLines: Int) {
        super.init(style: .default, reuseIdentifier: "detail")
        
        backgroundColor = ArkPalette.backgroundColor
        selectionStyle  = .none
        
        titleLabel               = ArkCopyableLabel()
        titleLabel.text          = title
        titleLabel.textColor     = ArkPalette.accentColor
        titleLabel.font          = UIFont.systemFont(ofSize: 15.0, weight:  .semibold)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = numberOfLines
        titleLabel.adjustsFontSizeToFitWidth = true
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-12.5)
            make.left.equalTo(12.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
