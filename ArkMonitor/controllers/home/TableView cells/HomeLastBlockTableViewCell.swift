//
//  HomeLastBlockTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

extension HomeViewController {
    class HomeLastBlockTableViewCell: HomeTableViewCell {
        
        init(_ row: Int) {
            super.init(style: .default, reuseIdentifier: "forging")
        }
        
        public func update(_ block: Block) {
            descriptionLabel.text = "Last block forged"
            valueLabel.text = Utils.getTimeAgo(timestamp: Double(block.timestamp))
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}


