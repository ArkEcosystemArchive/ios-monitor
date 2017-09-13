//
//  HomeAddressTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

extension HomeViewController {
    class HomeAddressTableViewCell: HomeTableViewCell {
        
        init(_ row: Int) {
            super.init(style: .default, reuseIdentifier: "address")
            valueLabel.snp.remakeConstraints { (make) in
                make.top.bottom.right.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.75)
            }
        }
        
        public func update(_ delegate: Delegate) {
            descriptionLabel.text = "Address"
            valueLabel.text = delegate.address
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

