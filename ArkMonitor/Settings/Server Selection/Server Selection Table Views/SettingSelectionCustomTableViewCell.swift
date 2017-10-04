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

class SettingSelectionCustomTableViewCell: UITableViewCell {
    
    public  let server    : CustomServer
    private var nameLabel : UILabel!
    private var check     : UIImageView!
    public var isCurrentServer = false
    
    init(_ server: CustomServer) {
        self.server = server
        super.init(style: .default, reuseIdentifier: "customServer")
        
        backgroundColor = ArkPalette.backgroundColor
        selectionStyle = .none
        
        nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = server.name
        nameLabel.textColor = ArkPalette.highlightedTextColor
        nameLabel.font = UIFont.systemFont(ofSize: 16.0, weight:  .semibold)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(12.5)
        }

        let checkImage = #imageLiteral(resourceName: "serverCheck")
        check = UIImageView()
        check.image = checkImage.maskWithColor(color: ArkPalette.accentColor)
        check.isHidden = true
        
        addSubview(check)
        check.snp.makeConstraints { (make) in
            make.height.width.equalTo(25.0)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12.5)
        }
        
        let seperator = UIView()
        seperator.backgroundColor = ArkPalette.secondaryBackgroundColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
    public func setServerSelction(_ isCurrentServer: Bool) {
        self.isCurrentServer = isCurrentServer
        let checkImage = #imageLiteral(resourceName: "serverCheck")
        check.image = checkImage.maskWithColor(color: ArkPalette.accentColor)
        if isCurrentServer == true {
            nameLabel.textColor = ArkPalette.accentColor
            check.isHidden = false
        } else {
            nameLabel.textColor = ArkPalette.highlightedTextColor
            check.isHidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
