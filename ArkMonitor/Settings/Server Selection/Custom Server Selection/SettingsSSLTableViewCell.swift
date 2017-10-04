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

protocol SettingsSSLTableViewCellDelegate: class {
    func sslCell(_ cell: SettingsSSLTableViewCell, didChangeStatus enabled: Bool)
}

class SettingsSSLTableViewCell: UITableViewCell {
    
    public weak var delegate: SettingsSSLTableViewCellDelegate?
    
    var nameLabel  : UILabel!
    var sslSwitch  : UISwitch!
    
    init(reuseIdentifier: String) {
        super.init(style: .default, reuseIdentifier: "port")
        
        backgroundColor = ArkPalette.backgroundColor
        selectionStyle = .none
        
        
        nameLabel               = UILabel()
        nameLabel.text          = "SSL Enabled?"
        nameLabel.textColor     = ArkPalette.highlightedTextColor
        nameLabel.textAlignment = .left
        nameLabel.font          = UIFont.systemFont(ofSize: 16.0, weight:  .semibold)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(25.0)
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        
        sslSwitch             = UISwitch()
        sslSwitch.onTintColor = ArkPalette.accentColor
        sslSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        addSubview(sslSwitch)
        sslSwitch.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-25.0)
        }
        
        let seperator = UIView()
        seperator.backgroundColor = ArkPalette.secondaryBackgroundColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
    public func update(_ enabled: Bool) {
        sslSwitch.setOn(enabled, animated: false)
    }
    
    @objc private func switchValueChanged() {
        delegate?.sslCell(self, didChangeStatus: sslSwitch.isOn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



