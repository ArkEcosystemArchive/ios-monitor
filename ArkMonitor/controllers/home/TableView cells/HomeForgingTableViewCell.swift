//
//  HomeForgingTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

extension HomeViewController {
    class HomeForgingTableViewCell: HomeTableViewCell {
        
        private let row      : Int
        private let category : ForgingCategory
        
        enum ForgingCategory: Int {
            case forged  = 0
            case fees    = 1
            case rewards = 2
        }
        
        init(_ row: Int) {
            self.row = row
            self.category = ForgingCategory(rawValue: row)!
            super.init(style: .default, reuseIdentifier: "forging")
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


