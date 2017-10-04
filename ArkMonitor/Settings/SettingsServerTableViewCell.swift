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

class SettingsServerTableViewCell: UITableViewCell {
    
    var titleLabel    : UILabel!
    var currencyLabel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = ArkPalette.backgroundColor
        selectionStyle = .none
        titleLabel = UILabel()
        titleLabel.text = "Server"
        titleLabel.textColor = ArkPalette.highlightedTextColor
        titleLabel.font  = UIFont.systemFont(ofSize: 16.0, weight:  .semibold)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(15.0)
            make.width.equalTo(250.0)
        }
        
        let chevron = UIImageView(image: #imageLiteral(resourceName: "chevron"))
        addSubview(chevron)
        chevron.snp.makeConstraints { (make) in
            make.height.width.equalTo(15.0)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15.0)
        }
        
        currencyLabel = UILabel()
        currencyLabel.textAlignment = .right
        
        if let currentPreset = ArkNetworkManager.currentNetwork {
            switch currentPreset {
            case .arknode:
                currencyLabel.text = "arknode"
            case .arknet1:
                currencyLabel.text = "arknet1"
            case .arknet2:
                currencyLabel.text = "arknet2"
            }
        } else if ArkNetworkManager.CurrentCustomServer != nil {
            currencyLabel.text = "custom"
        } else {
            currencyLabel.text = "default"
        }
        currencyLabel.textColor = ArkPalette.textColor
        currencyLabel.font = UIFont.systemFont(ofSize: 18.0, weight:  .regular)
        addSubview(currencyLabel)
        currencyLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(100.0)
            make.right.equalTo(chevron.snp.left).offset(-10.0)
            
            
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
}
