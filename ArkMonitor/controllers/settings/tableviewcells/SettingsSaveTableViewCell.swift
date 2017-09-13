//
//  SettingsSaveTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-13.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit


protocol SettingsSaveTableViewCellDelegate: class {
    func saveCellButtonWasTapped(_ cell: SettingsSaveTableViewCell)
}

class SettingsSaveTableViewCell: UITableViewCell {
    
    var saveButton: UIButton!

    public weak var delegate: SettingsSaveTableViewCellDelegate?
    
    init(_ mode: ServerMode) {
        super.init(style: .default, reuseIdentifier: "username")
        
        backgroundColor = UIColor.white
        
        saveButton = UIButton()
        saveButton.title("Save", color: UIColor.white)
        saveButton.setBackgroundColor(ArkColors.blue, forState: UIControlState())
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 8.0
        addSubview(saveButton)
        saveButton.snp.makeConstraints { (make) in
            make.width.equalTo(250.0)
            make.height.equalTo(45.0)
            make.center.equalToSuperview()
        }
    }
    
    @objc private func saveButtonTapped() {
        delegate?.saveCellButtonWasTapped(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
