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

class CurrenctySelectionTableViewCell: UITableViewCell {
    
    public var currency  : Currency!
    public var nameLabel : UILabel!
    public var checkView : UIImageView!
    
    public func update(_ currency: Currency) {
        self.currency = currency
        let currencyInfo = CurrencyInfo(currency)
        nameLabel.text = currency.rawValue + " - " + currencyInfo.currencyName
    }
    
    public func currencySelected(_ selected: Bool) {
        if selected == true {
            checkView.isHidden = false
        } else {
            checkView.isHidden = true
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "currency")
        
        backgroundColor = ArkPalette.backgroundColor
        selectionStyle = .none
        
        nameLabel = UILabel()
        nameLabel.textColor = ArkPalette.highlightedTextColor
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  .semibold)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(15)
        }
        
        checkView = UIImageView(image: #imageLiteral(resourceName: "check"))
        checkView.isHidden = true
        addSubview(checkView)
        checkView.snp.makeConstraints { (make) in
            make.height.width.equalTo(30.0)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15.0)
        }
        
        
        let seperator = UIView()
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.left.equalTo(15.0)
            make.height.equalTo(1.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
}
