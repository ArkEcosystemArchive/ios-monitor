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

class ArkDetailTableViewCell: UITableViewCell {
    
    var titleLabel: ArkCopyableLabel!
    
    init(_ title: String, numberOfLines: Int) {
        super.init(style: .default, reuseIdentifier: "detail")
        
        backgroundColor = ArkPalette.backgroundColor
        selectionStyle  = .none
        
        titleLabel               = ArkCopyableLabel()
        titleLabel.text          = title
        titleLabel.textColor     = ArkPalette.accentColor
        titleLabel.font          = UIFont.systemFont(ofSize: 15.0, weight:  .semibold)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = numberOfLines
        titleLabel.adjustsFontSizeToFitWidth = true
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-12.5)
            make.left.equalTo(12.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
