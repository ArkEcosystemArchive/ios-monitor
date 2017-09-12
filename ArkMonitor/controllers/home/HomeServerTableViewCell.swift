//
//  HomeServerTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

extension HomeViewController1 {
    class HomeServerTableViewCell: UITableViewCell {
        
        private let row      : Int
        private let category : ServerCategory
        
        private var descriptionLabel : UILabel!
        private var valueLabel       : UILabel!
        
        enum ServerCategory: Int {
            case total     = 0
            case remaining = 1
        }
        
        init(_ row: Int) {
            self.row = row
            self.category = ServerCategory(rawValue: row)!
            super.init(style: .default, reuseIdentifier: "server")
            
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

