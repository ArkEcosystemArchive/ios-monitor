//
//  TickerInfo.swift
//  Dark
//
//  Created by Andrew on 2017-09-23.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit
import SwiftyArk


struct CurrencyInfo {
    
    public let currency     : Currency
    public let currencyName : String
    public let currencyUnit : String
    
    init(_ currency: Currency) {
        self.currency = currency
        switch currency {
        case .aud:
            currencyName = "Australian Dollar"
            currencyUnit = "$"
        case .brl:
            currencyName = "Brazilian Real"
            currencyUnit = "R$"
        case .cad:
            currencyName = "Canadian Dollar"
            currencyUnit = "$"
        case .chf:
            currencyName = "Swiss Franc"
            currencyUnit = "SFr."
        case .clp:
            currencyName = "Chilean Peso"
            currencyUnit = "$"
        case .cny:
            currencyName = "Chinese Yuan"
            currencyUnit = "\u{A5}"
        case .czk:
            currencyName = "Czech Koruna"
            currencyUnit = "Kč"
        case .dkk:
            currencyName = "Danish Krone"
            currencyUnit = "kr"
        case .eur:
            currencyName = "Euro"
            currencyUnit = "€"
        case .gbp:
            currencyName = "British Pound"
            currencyUnit = "£"
        case .hkd:
            currencyName = "Hong Kong Dollar"
            currencyUnit = "HKD"
        case .huf:
            currencyName = "Hungarian Forint"
            currencyUnit = "Ft"
        case .idr:
            currencyName = "Indonesian Rupiah"
            currencyUnit = "Rp"
        case .ils:
            currencyName = "Israeli Shekel"
            currencyUnit = "₪"
        case .inr:
            currencyName = "Indian Rupee"
            currencyUnit = "₹"
        case .jpy:
            currencyName = "Japanese Yen"
            currencyUnit = "¥"
        case .krw:
            currencyName = "Korean Won"
            currencyUnit = "₩"
        case .mxn:
            currencyName = "Mexican Peso"
            currencyUnit = "$"
        case .myr:
            currencyName = "Malaysian Ringgit"
            currencyUnit = "RM"
        case .nok:
            currencyName = "Norwegian Krone"
            currencyUnit = "kr"
        case .nzd:
            currencyName = "New Zealand dollar"
            currencyUnit = "$"
        case .php:
            currencyName = "Philippines Peso"
            currencyUnit = "₱"
        case .pkr:
            currencyName = "Pakistani Rupee"
            currencyUnit = "₨"
        case .pln:
            currencyName = "Polish Zloty"
            currencyUnit = "zł"
        case .rub:
            currencyName = "Russian Ruble"
            currencyUnit = "₽"
        case .sek:
            currencyName = "Swedish Krona"
            currencyUnit = "kr"
        case .sgd:
            currencyName = "Singapore Dollar"
            currencyUnit = "$"
        case .thb:
            currencyName = "Thailand Baht"
            currencyUnit = "฿"
        case .twd:
            currencyName = "Taiwan New Dollar"
            currencyUnit = "NT$"
        case .usd:
            currencyName = "United States Dollar"
            currencyUnit = "$"
        case .zar:
            currencyName = "South Africa Rand"
            currencyUnit = "R"
        }
    }
}




