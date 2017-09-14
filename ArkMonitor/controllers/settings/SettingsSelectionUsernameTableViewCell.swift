//
//  SettingsSelectionUsernameTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-14.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

protocol SettingsSelectionUsernameTableViewCellDelegate: class {
    func usernameCell(_ cell: SettingsSelectionUsernameTableViewCell, didChangeText text: String?)
}

class SettingsSelectionUsernameTableViewCell: UITableViewCell {
    
    public weak var delegate: SettingsSelectionUsernameTableViewCellDelegate?
    
    var nameLabel      : UILabel!
    var nameTextField  : ArkTextField!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "username")
        
        backgroundColor = ArkPalette.secondaryBackgroundColor
        selectionStyle = .none
        
        nameTextField = ArkTextField(placeHolder: "enter here")
        nameTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        addSubview(nameTextField)
        nameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(12.5)
            make.right.equalToSuperview().offset(-12.5)
            make.height.equalToSuperview().offset(-10.0)
            make.centerY.equalToSuperview()
        }
        
        let seperator = UIView()
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
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
extension SettingsSelectionUsernameTableViewCell : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        delegate?.usernameCell(self, didChangeText: textField.text)
    }
}
