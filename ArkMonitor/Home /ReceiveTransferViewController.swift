//
//  ReceiveTransferViewController.swift
//  Dark
//
//  Created by Andrew on 2017-09-24.
//  Copyright © 2017 Walzy. All rights reserved.
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
        navigationItem.title = "Transfer"
        
        let bottomButton = UIButton()
        bottomButton.backgroundColor = ArkPalette.accentColor
        bottomButton.setTitle("Copy Address", for: UIControlState())
        bottomButton.setTitleColor(ArkPalette.highlightedTextColor, for: UIControlState())
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
        addressDescription.text          = "ARK ADDRESS"
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
        ArkActivityView.showMessage("Address successfully copied!", style: .success)
    }
}
