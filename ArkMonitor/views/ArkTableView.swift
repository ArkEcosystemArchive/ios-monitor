//
//  ArkTableView.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-12.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

class ArkTableView: UITableView, UIGestureRecognizerDelegate {
    
    public var showEmptyNotice = true
    
    init(frame: CGRect) {
        super.init(frame: frame, style: .grouped)
        backgroundColor              = ArkPalette.backgroundColor
        separatorStyle               = .none
        showsVerticalScrollIndicator = false
        panGestureRecognizer.delegate = self
        
        let anotherPanGesture = UIPanGestureRecognizer(target: self, action: #selector(twoFingerPan(_:)))
        anotherPanGesture.minimumNumberOfTouches = 2
        anotherPanGesture.maximumNumberOfTouches = 2
        addGestureRecognizer(anotherPanGesture)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reloadData() {
        super.reloadData()
        
        guard showEmptyNotice == true else {
            return
        }
        
        if visibleCells.isEmpty == true {
            let emptyBackgroundView = UIView(frame: frame)
            let emptyLabel = UILabel()
            emptyLabel.textColor = ArkPalette.textColor
            emptyLabel.font = UIFont.systemFont(ofSize: 18.0, weight:  ArkPalette.fontWeight)
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
    
    @objc private func twoFingerPan(_ pan: UIPanGestureRecognizer) {
        let translation = pan.translation(in: self).y
        
        if translation > 100.0 && isDarkMode == false {
            isDarkMode = true
            ArkHaptics.selectionChanged()
        }
        
        if translation < -100.0 && isDarkMode == true {
            isDarkMode = false
            ArkHaptics.selectionChanged()
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

// MARK: UIGestureRecognizerDelegate
extension HomeViewController: UIGestureRecognizerDelegate {
    

}


