//
//  PeerSectionHeader.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class PeerSectionHeader: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        let ipLabel = UILabel()
        ipLabel.textColor = ArkColors.darkGray
        ipLabel.text = "Ip Address"
        ipLabel.textAlignment = .center
        ipLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(ipLabel)
        
        ipLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        let portLabel = UILabel()
        portLabel.textColor = ArkColors.darkGray
        portLabel.text = "Port"
        portLabel.textAlignment = .center
        portLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(portLabel)
        
        portLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(ipLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        let versionLabel = UILabel()
        versionLabel.textColor = ArkColors.darkGray
        versionLabel.text = "Version"
        versionLabel.textAlignment = .center
        versionLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(versionLabel)
        
        versionLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(portLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
