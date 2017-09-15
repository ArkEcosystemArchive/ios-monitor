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
    var seperator    : UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle  = .none
        
        ipLabel = UILabel()
        ipLabel.textColor = ArkPalette.textColor
        ipLabel.textAlignment = .center
        ipLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        addSubview(ipLabel)
        
        ipLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo((_screenWidth / 3.0) - 10.0)
            make.centerX.equalTo(_screenWidth / 6.0)
        }
        
        portLabel = UILabel()
        portLabel.textColor = ArkPalette.textColor
        portLabel.textAlignment = .center
        portLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        addSubview(portLabel)
        
        portLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo((_screenWidth / 3.0) - 10.0)
            make.centerX.equalTo(_screenWidth / 2.0)
        }
        
        versionLabel = UILabel()
        versionLabel.textColor = ArkPalette.textColor
        versionLabel.textAlignment = .center
        versionLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        addSubview(versionLabel)
        
        versionLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo((_screenWidth / 3.0) - 10.0)
            make.centerX.equalTo(_screenWidth * 5.0 / 6.0)
        }
        
        seperator = UIView()
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(_ peer: Peer) {
        ipLabel.text = peer.ip
        portLabel.text =  String(peer.port)
        versionLabel.text = peer.version
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        backgroundColor = ArkPalette.secondaryBackgroundColor


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
            ipLabel.textColor      = ArkPalette.textColor
            portLabel.textColor    = ArkPalette.textColor
            versionLabel.textColor = ArkPalette.textColor
            
        }
    }
}
