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
    internal var valueLabel       : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white
        selectionStyle = .none
        
        descriptionLabel = UILabel()
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = ArkColors.gray
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(12.5)
        }
        
        valueLabel = UILabel()
        valueLabel.textAlignment = .right
        valueLabel.textColor = ArkColors.blue
        addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-12.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
}
