//
//  HomeDelegateTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

extension HomeViewController {
class HomeDelegateTableViewCell: HomeTableViewCell {
    
    private let row      : Int
    private let category : DelegateCategory
    
    enum DelegateCategory: Int {
        case name         = 0
        case rank         = 1
        case productivity = 2
        case forged       = 3
        case approval     = 4
    }
    
    init(_ row: Int) {
        self.row = row
        self.category = DelegateCategory(rawValue: row)!
        super.init(style: .default, reuseIdentifier: "delegate")
    }
    
    public func update(_ delegate: Delegate) {
        switch category {
        case .name:
            descriptionLabel.text = "Name"
            valueLabel.text = delegate.username
            valueLabel.text = "Testy123"
        case .rank:
            descriptionLabel.text = "Rank / Status"
            let rankStatus : String = delegate.rate <= 51 ? "Active" : "Standby"
            valueLabel.text = String(delegate.rate) + " / " + rankStatus
        case .productivity:
            descriptionLabel.text = "Productivity"
            valueLabel.text = String(delegate.productivity) + "%"
        case .forged:
            descriptionLabel.text = "Forged / Missed blocks"
            valueLabel.text = String(delegate.producedblocks) + " / " + String(delegate.missedblocks)
        case .approval:
            descriptionLabel.text = "Approval"
            valueLabel.text = String(delegate.approval) + "%"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
}
