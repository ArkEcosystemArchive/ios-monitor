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

class ReceiveTransferViewController: ArkViewController {
    
    private let account            : Account
    private var qrCodeView         : UIImageView!
    private var addressDescription : UILabel!

    
    init(_ account: Account) {
        self.account = account
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("Account", comment: "")
        
        let bottomButton = UIButton()
        bottomButton.backgroundColor = ArkPalette.accentColor
        bottomButton.setTitle(NSLocalizedString("ReceiveTransfer.CopyAddress", comment: ""), for: .normal)
        bottomButton.setTitleColor(ArkPalette.highlightedTextColor, for: .normal)
        bottomButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        bottomButton.addTarget(self, action: #selector(copyAddressToClipboard), for: .touchUpInside)
        view.addSubview(bottomButton)
        bottomButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(45.0)
            make.bottom.equalToSuperview().offset(-49.0)
        }
        
        let arkAddressLabel           = UILabel()
        arkAddressLabel.text          = account.address
        arkAddressLabel.textColor     = ArkPalette.highlightedTextColor
        arkAddressLabel.font          = UIFont.systemFont(ofSize: 16.0)
        arkAddressLabel.adjustsFontSizeToFitWidth = true
        arkAddressLabel.textAlignment = .center
        view.addSubview(arkAddressLabel)
        arkAddressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(25.0)
            make.right.equalToSuperview().offset(-25.0)
            make.height.equalTo(25.0)
            make.centerY.equalTo(_screenHeight * 0.6)
        }
        
        addressDescription           = UILabel()
        addressDescription.textAlignment = .center
        addressDescription.textColor     = ArkPalette.highlightedTextColor
        addressDescription.font          = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        addressDescription.text          = NSLocalizedString("ArkAddress", comment: "").uppercased()
        view.addSubview(addressDescription)
        addressDescription.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(25.0)
            make.bottom.equalTo(arkAddressLabel).offset(-25.0)
        }
        
        let spacer = UIView()
        view.addSubview(spacer)
        spacer.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(addressDescription.snp.top)
        }
        
        if let qrCodeImage = account.qrCode() {
            qrCodeView = UIImageView(image: qrCodeImage)
            spacer.addSubview(qrCodeView)
            qrCodeView.snp.makeConstraints{ (make) in
                make.height.width.equalTo(_screenWidth * 0.6)
                make.center.equalToSuperview()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc private func copyAddressToClipboard() {
        UIPasteboard.general.string = account.address
        ArkActivityView.showMessage(NSLocalizedString("ReceiveTransfer.AddressSuccessfullyCopied", comment: ""), style: .success)
    }
}
