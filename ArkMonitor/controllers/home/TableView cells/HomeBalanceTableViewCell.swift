//
//  HomeBalanceTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-11.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

extension HomeViewController {
    class HomeBalanceTableViewCell: HomeTableViewCell {
        
        enum BalanceCategory: Int {
            case balance = 1
            case btc     = 2
            case usd     = 3
            case eur     = 4
        }
        
        private let category: BalanceCategory
        
        init(_ row: Int) {
            self.category = BalanceCategory(rawValue: row)!
            super.init(style: .default, reuseIdentifier: "Balance")
        }
        
        public func update(balance: Double?, arkBTCValue: Double?,  bitcoinUSDValue: Double?, bitcoinEURValue: Double?) {
            switch category {
            case .balance:
                descriptionLabel.text = "Total balance"
                valueLabel.text = String(Utils.convertToArkBase(value: Int64(balance ?? 0.00)))
            case .btc:
                descriptionLabel.text = "BTC equivalent"
                if let aBalance = balance,
                    let value = arkBTCValue {
                    let balanceBtcEquivalent = aBalance * value
                    valueLabel.text = String(Utils.convertToArkBase(value: Int64(balanceBtcEquivalent)))
                }
            case .usd:
                descriptionLabel.text = "USD equivalent"
                if let btcValue = arkBTCValue,
                    let cBalance = balance,
                    let value = bitcoinUSDValue {
                    let balanceUSDEquivalent = btcValue * value * cBalance
                    valueLabel.text = String(Utils.convertToArkBase(value: Int64(balanceUSDEquivalent)))
                }
            case .eur:
                descriptionLabel.text = "EUR equivalent"
                if let btcValue = arkBTCValue,
                    let cBalance = balance,
                    let value = bitcoinEURValue {
                    let balanceUSDEquivalent = btcValue * value * cBalance
                    valueLabel.text = String(Utils.convertToArkBase(value: Int64(balanceUSDEquivalent)))
                }
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

