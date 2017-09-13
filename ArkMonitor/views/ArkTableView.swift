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
    
    override func reloadData() {
        super.reloadData()
        if visibleCells.isEmpty == true {
            let emptyBackgroundView = UIView(frame: frame)
            let emptyLabel = UILabel()
            emptyLabel.textColor = ArkColors.blue
            emptyLabel.textAlignment = .center
            emptyLabel.text = "No data available"
            emptyBackgroundView.addSubview(emptyLabel)
            emptyLabel.snp.makeConstraints { (make) in
                make.left.right.top.bottom.equalToSuperview()
            }
            backgroundView = emptyBackgroundView
        } else {
            let blankView = UIView()
            backgroundView = blankView
        }
    }
}
