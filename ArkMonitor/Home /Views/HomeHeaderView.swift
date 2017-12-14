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

protocol HomeHeaderViewDelegate: class {
    func headerDidTapQRCodeButton(_ view: HomeViewController.HomeHeaderView)
}

extension HomeViewController {
class HomeHeaderView: UIView {
    
    fileprivate enum ValueMode {
        case bitcoin
        case currency
    }
    
    public weak var delegate : HomeHeaderViewDelegate?
    
    private var qrcodeButton   : UIButton!
    private var arkLabel       : UILabel!
    private var quantityLabel  : UILabel!
    private var priceLabel     : UILabel!
    private var priceInfoLabel : UILabel!
    private var balance        : Double?
    private var ticker         : TickerStruct?
    private var valueMode      = ValueMode.currency
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ArkPalette.backgroundColor
        
        
        qrcodeButton = UIButton()
        qrcodeButton.addTarget(self, action: #selector(qrButtonTapped), for: .touchUpInside)
        qrcodeButton.setImage(#imageLiteral(resourceName: "qrCode"), for: .normal)
        addSubview(qrcodeButton)
        qrcodeButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(30.0)
            make.right.equalToSuperview().offset(-15.0)
            make.centerY.equalTo(30.0)
        }
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        
        arkLabel = UILabel()
        arkLabel.text = "ARK"
        arkLabel.textAlignment = .center
        arkLabel.textColor = ArkPalette.accentColor
        arkLabel.font = UIFont.systemFont(ofSize: 27.5, weight: .semibold)
        arkLabel.isUserInteractionEnabled = true
        arkLabel.addGestureRecognizer(tap1)
        
        addSubview(arkLabel)
        arkLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30.0)
            make.width.equalTo(100.0)
            make.top.equalTo(40.0)
            make.centerX.equalToSuperview()
        }
        
        priceInfoLabel = UILabel()
        priceInfoLabel.textAlignment = .center
        priceInfoLabel.textColor = ArkPalette.accentColor
        priceInfoLabel.isUserInteractionEnabled = true
        priceInfoLabel.addGestureRecognizer(tap2)
        priceInfoLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .light)
        addSubview(priceInfoLabel)
        priceInfoLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(20.0)
            make.top.equalTo(arkLabel.snp.bottom)
        }
        
        let spacer = UIView()
        addSubview(spacer)
        spacer.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(priceInfoLabel.snp.bottom)
        }
        
        let labelSpacer = UIView()
        spacer.addSubview(labelSpacer)
        labelSpacer.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(75.0)
            make.center.equalToSuperview()
        }
        
        quantityLabel = UILabel()
        quantityLabel.textColor = ArkPalette.highlightedTextColor
        quantityLabel.textAlignment = .center
        quantityLabel.font = UIFont.systemFont(ofSize: 37.5, weight: .bold)
        quantityLabel.isUserInteractionEnabled = true
        quantityLabel.addGestureRecognizer(tap3)
        labelSpacer.addSubview(quantityLabel)
        quantityLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(40.0)
        }
        
        priceLabel               = UILabel()
        priceLabel.textColor     = ArkPalette.highlightedTextColor
        priceLabel.textAlignment = .center
        priceLabel.font          = UIFont.systemFont(ofSize: 30.0, weight: .light)
        priceLabel.isUserInteractionEnabled = true
        priceLabel.addGestureRecognizer(tap4)
        labelSpacer.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(35.0)
        }
    }

    public func update(_ account: Account) {
        balance = account.balance
        updateLabels()
    }
    
    public func update(_ ticker: TickerStruct) {
        self.ticker = ticker
        updateLabels()
    }
    
    @objc private func labelTapped() {
        if valueMode == .currency {
            valueMode = .bitcoin
        } else{
            valueMode = .currency
        }
        updateLabels()
    }
    
    @objc private func qrButtonTapped() {
        delegate?.headerDidTapQRCodeButton(self)
    }
    
    private func updateLabels() {
        if let currentBalance = balance {
            quantityLabel.text = currentBalance.formatString(4)
        }
        
        if let currentTicker  = ticker {
            if valueMode == .currency {
                priceInfoLabel.text = "1 ARK = \(currentTicker.price.formatString(2)) \(currentTicker.currency.rawValue)"
            } else {
                priceInfoLabel.text = "1 ARK = \u{243}\(currentTicker.bitcoinPrice.formatString(7))"
            }
        }
        
        if let currentBalance = balance,
           let currentTicker  = ticker {
            if valueMode == .currency {
                let price = currentBalance * currentTicker.price
                let currencyInfo = CurrencyInfo(currentTicker.currency)
                priceLabel.text = "\(currencyInfo.currencyUnit) " + price.formatString(2)
            } else {
                let bitcoinPrice = currentBalance * currentTicker.bitcoinPrice
                priceLabel.text = "\u{243} " + bitcoinPrice.formatString(5)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
}
