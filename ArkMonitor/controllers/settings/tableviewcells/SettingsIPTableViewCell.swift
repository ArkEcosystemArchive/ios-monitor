//
//  SettingsIPTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-13.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

protocol SettingsIPTableViewCellDelegate: class {
    func ipCell(_ cell: SettingsIPTableViewCell, didChangeText text: String?)
}

class SettingsIPTableViewCell: UITableViewCell {
    
    public weak var delegate: SettingsIPTableViewCellDelegate?
    
    var nameLabel      : UILabel!
    var nameTextField  : ArkTextField!
    
    init(_ mode: Server) {
        super.init(style: .default, reuseIdentifier: "ip")
        
        backgroundColor = UIColor.white
        selectionStyle = .none

        
        let nameLabel = UILabel()
        nameLabel.text          = "IP Address"
        nameLabel.textColor     = ArkColors.darkGray
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 16.0)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(25.0)
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        
        nameTextField = ArkTextField(placeHolder: "")
        nameTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        addSubview(nameTextField)
        nameTextField.snp.makeConstraints { (make) in
            make.height.equalTo(30.0)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-25.0)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(_ ipAddress: String?) {
        nameTextField.text = ipAddress
    }
}

// MARK: UITextFieldDelegate
extension SettingsIPTableViewCell : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        delegate?.ipCell(self, didChangeText: textField.text)
    }
}
