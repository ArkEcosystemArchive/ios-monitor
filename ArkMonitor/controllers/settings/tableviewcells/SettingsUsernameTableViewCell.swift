//
//  SettingsUsernameTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-13.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

protocol SettingsUsernameTableViewCellDelegate: class {
    func usernameCell(_ cell: SettingsUsernameTableViewCell, didChangeText text: String?)
}

class SettingsUsernameTableViewCell: UITableViewCell {
    
    public weak var delegate: SettingsUsernameTableViewCellDelegate?
    
    var nameLabel      : UILabel!
    var nameTextField  : ArkTextField!
    
    init(_ mode: Server) {
        super.init(style: .default, reuseIdentifier: "username")
        
        backgroundColor = ArkPalette.backgroundColor
        selectionStyle = .none
        
        let nameLabel = UILabel()
        nameLabel.text          = "Username"
        nameLabel.textColor     = ArkPalette.highlightedTextColor
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 16.0)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(25.0)
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        
        nameTextField = ArkTextField(placeHolder: "enter here")
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
    
    public func update(_ username: String?) {
        nameTextField.text = username
    }
}

// MARK: UITextFieldDelegate
extension SettingsUsernameTableViewCell : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        delegate?.usernameCell(self, didChangeText: textField.text)
    }
}
