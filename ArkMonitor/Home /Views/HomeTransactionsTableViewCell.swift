//
//  HomeTransactionsTableViewCell.swift
//  Dark
//
//  Created by Andrew on 2017-09-20.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit
import SwiftyArk

extension HomeViewController {
class HomeTransactionsTableViewCell: UITableViewCell {
    
    private var typeLabel     : UILabel!
    private var dateLabel     : UILabel!
    private var quantityLabel : UILabel!
    private var iconView      : UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    private func setupView() {
        backgroundColor         = ArkPalette.backgroundColor
        
        iconView = UIImageView()
        addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.height.width.equalTo(25.0)
            make.centerY.equalToSuperview()
            make.left.equalTo(12.5)
        }
        typeLabel               = UILabel()
        typeLabel.textColor     = ArkPalette.highlightedTextColor
        typeLabel.textAlignment = .left
        typeLabel.font          = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        addSubview(typeLabel)
        typeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20.0)
            make.width.equalTo(150.0)
            make.left.equalTo(50.0)
            make.centerY.equalTo(65.0 / 3.0)
        }
        
        dateLabel               = UILabel()
        dateLabel.textColor     = ArkPalette.highlightedTextColor
        dateLabel.textAlignment = .left
        dateLabel.font          = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20.0)
            make.width.equalTo(150.0)
            make.left.equalTo(50.0)
            make.centerY.equalTo(65.0 * 2.0 / 3.0)
        }
        
        quantityLabel               = UILabel()
        quantityLabel.textColor     = ArkPalette.accentColor
        quantityLabel.textAlignment = .right
        quantityLabel.font          = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        addSubview(quantityLabel)
        quantityLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20.0)
            make.width.equalTo(150.0)
            make.right.equalToSuperview().offset(-10.0)
            make.centerY.equalToSuperview()
        }
        
        let seperator = UIView()
        seperator.backgroundColor = ArkPalette.tertiaryBackgroundColor
        addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview()
            make.height.equalTo(1.0)
            make.left.equalTo(25.0)
        }
    }
    
    public func update(_ transaction: Transaction) {
        switch transaction.status() {
        case .received:
            typeLabel.text = "RECEIVED"
            iconView.image = #imageLiteral(resourceName: "receivedCellIcon")
            quantityLabel.text = transaction.amount.formatString(3) + " Ark"
        case .sent:
            typeLabel.text = "SENT"
            iconView.image = #imageLiteral(resourceName: "sendCellIcon")
            quantityLabel.text = (-transaction.amount - transaction.fee).formatString(3)  + " Ark"
        case .vote:
            typeLabel.text = "VOTE"
            iconView.image = #imageLiteral(resourceName: "voteCellIcon")
            quantityLabel.text = (-transaction.amount - transaction.fee).formatString(3)  + " Ark"
        default:
            typeLabel.text = ""
            quantityLabel.text = ""
            iconView.image = nil
        }
        
        dateLabel.text = transaction.timestamp.longStyleDateString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
}
