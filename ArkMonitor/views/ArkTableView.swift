//
//  ArkTableView.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class ArkTableView: UITableView {
    
    init(frame: CGRect) {
        super.init(frame: frame, style: .grouped)
        backgroundColor              = UIColor.white
        separatorStyle               = .none
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
