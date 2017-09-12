//
//  TransactionDetailTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class TransactionDetailTableViewCell: UITableViewCell {
    
    init(_ title: String) {
        super.init(style: .default, reuseIdentifier: "detail")
        
        backgroundColor = UIColor.white
        selectionStyle  = .none
        
        let titleLabel           = UILabel()
        titleLabel.text          = title
        titleLabel.textColor     = ArkColors.blue
        titleLabel.font          = UIFont.systemFont(ofSize: 14.0)
        titleLabel.textAlignment = .left
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(12.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
