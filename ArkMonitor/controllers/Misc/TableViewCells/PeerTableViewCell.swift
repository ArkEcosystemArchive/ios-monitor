//
//  PeerTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class PeerTableViewCell: UITableViewCell {
    
    var ipLabel      : UILabel!
    var portLabel    : UILabel!
    var versionLabel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white
        selectionStyle  = .none
        
        ipLabel = UILabel()
        ipLabel.textColor = ArkColors.blue
        ipLabel.textAlignment = .center
        ipLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(ipLabel)
        
        ipLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        portLabel = UILabel()
        portLabel.textColor = ArkColors.gray
        portLabel.textAlignment = .center
        portLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(portLabel)
        
        portLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(ipLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        versionLabel = UILabel()
        versionLabel.textColor = ArkColors.gray
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
    
    public func update(_ peer: Peer) {
        ipLabel.text = peer.ip
        portLabel.text =  String(peer.port)
        versionLabel.text = peer.version
        
        let state : PeerStatus = PeerStatus.fromState(state: peer.status)
        
        switch state {
        case .banned:
            ipLabel.textColor      = UIColor.red
            portLabel.textColor    = UIColor.red
            versionLabel.textColor = UIColor.red
        case .disconnected:
            ipLabel.textColor      = UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1.0)
            portLabel.textColor    = UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1.0)
            versionLabel.textColor = UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1.0)
        default:
            ipLabel.textColor      = ArkColors.blue
            portLabel.textColor    = ArkColors.gray
            versionLabel.textColor = ArkColors.gray
            
        }
    }
}
