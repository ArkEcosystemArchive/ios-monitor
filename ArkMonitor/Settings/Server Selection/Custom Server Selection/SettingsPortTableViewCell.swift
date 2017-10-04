// Copyright (c) 2016 Ark
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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

