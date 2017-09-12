//
//  HomeForgingTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

extension HomeViewController1 {
    class HomeForgingTableViewCell: UITableViewCell {
        
        private let row      : Int
        private let category : ForgingCategory
        
        private var descriptionLabel : UILabel!
        private var valueLabel       : UILabel!
        
        enum ForgingCategory: Int {
            case forged  = 0
            case fees    = 1
            case rewards = 2
        }
        
        init(_ row: Int) {
            self.row = row
            self.category = ForgingCategory(rawValue: row)!
            super.init(style: .default, reuseIdentifier: "forging")
            
            descriptionLabel = UILabel()
            descriptionLabel.textAlignment = .left
            addSubview(descriptionLabel)
            descriptionLabel.snp.makeConstraints { (make) in
                make.right.top.bottom.equalToSuperview()
                make.left.equalTo(12.5)
            }
            
            valueLabel = UILabel()
            valueLabel.textAlignment = .right
            addSubview(valueLabel)
            valueLabel.snp.makeConstraints { (make) in
                make.left.top.bottom.equalToSuperview()
                make.right.equalToSuperview().offset(-12.5)
            }
        }
        
        public func update(_ forging: Forging) {
            switch category {
            case .forged:
                descriptionLabel.text = "Forged"
                valueLabel.text = String(Utils.convertToArkBase(value: forging.forged))
            case .fees:
                descriptionLabel.text = "Fees"
                valueLabel.text = String(Utils.convertToArkBase(value: forging.fees))
            case .rewards:
                descriptionLabel.text = "Rewards"
                valueLabel.text = String(Utils.convertToArkBase(value: forging.rewards))
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}


