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




