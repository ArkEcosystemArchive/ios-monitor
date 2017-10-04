//
//  ArkTableView.swift
//  Dark
//
//  Created by Andrew on 2017-09-22.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit

class ArkTableView: UITableView {
    
    init(_ frame: CGRect) {
        super.init(frame: frame, style: .grouped)
        separatorStyle  = .none
        backgroundColor = ArkPalette.backgroundColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
