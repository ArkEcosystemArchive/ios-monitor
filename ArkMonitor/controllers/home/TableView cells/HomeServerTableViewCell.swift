//
//  HomeServerTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

extension HomeViewController {
    class HomeServerTableViewCell: HomeTableViewCell {
        
        private let row      : Int
        private let category : ServerCategory
        
        enum ServerCategory: Int {
            case total     = 0
            case remaining = 1
        }
        
        init(_ row: Int) {
            self.row = row
            self.category = ServerCategory(rawValue: row)!
            super.init(style: .default, reuseIdentifier: "server")
        }
        
        public func update(_ status: Status) {
            switch category {
            case .total:
                descriptionLabel.text = "Total blocks"
                valueLabel.text =  String(status.height)
            case .remaining:
                descriptionLabel.text = "Blocks remaining"
                valueLabel.text = String(status.blocks)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

