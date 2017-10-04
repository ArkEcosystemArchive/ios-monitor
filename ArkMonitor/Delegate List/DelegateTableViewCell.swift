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
import SwiftyArk

class DelegateTableViewCell: UITableViewCell {
    
    var delegate : Delegate?
    
    var rankLabel         : UILabel!
    var nameLabel         : UILabel!
    var approvalLabel     : UILabel!
    var productivityLabel : UILabel!
    var seperator         : UIView!
    
    public func update(_ delegate: Delegate) {
        self.delegate          = delegate
        rankLabel.text         = String(delegate.rate)
        nameLabel.text         = delegate.username
        approvalLabel.text     = String(delegate.approval) + "%"
        productivityLabel.text = String(delegate.productivity) + "%"
        
        if delegate.publicKey == ArkDataManager.currentVote?.publicKey {
            rankLabel.textColor         = ArkPalette.accentColor
            nameLabel.textColor         = ArkPalette.accentColor
            approvalLabel.textColor     = ArkPalette.accentColor
            productivityLabel.textColor = ArkPalette.accentColor
        } else {
            rankLabel.textColor         = ArkPalette.highlightedTextColor
            nameLabel.textColor         = ArkPalette.highlightedTextColor
            approvalLabel.textColor     = ArkPalette.highlightedTextColor
            productivityLabel.textColor = ArkPalette.highlightedTextColor
        }
        
        backgroundColor = ArkPalette.backgroundColor
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = ArkPalette.backgroundColor
        selectionStyle = .none
        
        rankLabel = UILabel()
        rankLabel.textColor = ArkPalette.accentColor
        rankLabel.textAlignment = .center
        rankLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        addSubview(rankLabel)
        
        rankLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.16)
        }
        
        nameLabel = UILabel()
        nameLabel.textColor = ArkPalette.highlightedTextColor
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  .semibold)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(rankLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.28)
        }
        
        approvalLabel = UILabel()
        approvalLabel.textColor = ArkPalette.highlightedTextColor
        approvalLabel.textAlignment = .center
        approvalLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  .semibold)
        addSubview(approvalLabel)
        
        approvalLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(nameLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.28)
        }
        
        productivityLabel = UILabel()
        productivityLabel.textColor = ArkPalette.highlightedTextColor
        productivityLabel.textAlignment = .center
        productivityLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  .semibold)
        addSubview(productivityLabel)
        
        productivityLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(approvalLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(0.28)
        }
        
        seperator = UIView()
        seperator.backgroundColor = ArkPalette.secondaryBackgroundColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
