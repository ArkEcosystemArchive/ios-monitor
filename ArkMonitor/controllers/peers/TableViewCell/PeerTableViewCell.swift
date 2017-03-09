//
//  PeerTableViewCell.swift
//  ArkMonitor
//
//  Created by Victor Lins on 24/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class PeerTableViewCell: BaseTableViewCell {

    @IBOutlet weak var ipLabel: UILabel!
    @IBOutlet weak var portLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!

    override class func height() -> CGFloat {
        return 44
    }

    override func setData(_ data: Any?) {
        if let data = data as? Peer {
            self.ipLabel.text = data.ip
            self.portLabel.text =  String(data.port)
            self.versionLabel.text = data.version
            
            let state : PeerState = PeerState.fromState(state: data.state)
            
            switch (state){
            case .banned:
                self.statusImageView.image = UIImage(named: "ic_banned")
                break
            case .disconnected:
                self.statusImageView.image = UIImage(named: "ic_disconnected")
                break
            case .connected:
                self.statusImageView.image = UIImage(named: "ic_connected")
                break
            default:
                self.statusImageView.image = nil
                break
            }
        }
    }
    
    
    func setTitles() {
        self.ipLabel.text = "Ip Address"
        self.portLabel.text = "Port"
        self.versionLabel.text = "Version"
        self.statusImageView.image = nil
    }
}
