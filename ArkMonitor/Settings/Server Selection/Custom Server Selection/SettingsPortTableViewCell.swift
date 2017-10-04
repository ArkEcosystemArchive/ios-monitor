//
//  SettingsPortTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-13.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

protocol SettingsPortTableViewCellDelegate: class {
    func portCell(_ cell: SettingsPortTableViewCell, didChangeText text: String?)
}

class SettingsPortTableViewCell: UITableViewCell {
    
    public weak var delegate: SettingsPortTableViewCellDelegate?
    
    var nameLabel      : UILabel!
    var nameTextField  : ArkServerTextField!
    
    init(reuseIdentifier: String) {
        super.init(style: .default, reuseIdentifier: "port")
        
        backgroundColor = ArkPalette.backgroundColor
        selectionStyle = .none
        
        
        let nameLabel = UILabel()
        nameLabel.text          = "Port"
        nameLabel.textColor     = ArkPalette.highlightedTextColor
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 16.0, weight:  .semibold)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(25.0)
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        
        nameTextField = ArkServerTextField(settings: true, placeHolder: "4001")
        nameTextField.keyboardType = .numberPad
        nameTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        addSubview(nameTextField)
        nameTextField.snp.makeConstraints { (make) in
            make.height.equalTo(30.0)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-25.0)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        let seperator = UIView()
        seperator.backgroundColor = ArkPalette.secondaryBackgroundColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(_ port: String) {
        nameTextField.text = port
    }
}

// MARK: UITextFieldDelegate
extension SettingsPortTableViewCell : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        delegate?.portCell(self, didChangeText: textField.text)
    }
}

