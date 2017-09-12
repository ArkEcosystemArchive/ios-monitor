//
//  HomeVersionTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

extension HomeViewController1 {
    class HomeVersionTableViewCell: UITableViewCell {
        
        private var descriptionLabel : UILabel!
        private var valueLabel       : UILabel!
        
        init(_ row: Int) {
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
        
        public func update(_ peer: PeerVersion) {
            descriptionLabel.text = "Version"
            valueLabel.text =  peer.version
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

