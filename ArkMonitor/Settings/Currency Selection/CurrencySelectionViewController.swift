//
//  CurrencySelectionViewController.swift
//  Dark
//
//  Created by Andrew on 2017-09-23.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit

class CurrencySelectionViewController: ArkViewController {
    
    fileprivate var tableView : ArkTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Currency"
        
        tableView = ArkTableView(CGRect.zero)
        tableView.delegate       = self
        tableView.dataSource     = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

// MARK: UITableViewDelegate
extension CurrencySelectionViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let aCell = tableView.cellForRow(at: indexPath) as? CurrenctySelectionTableViewCell else {
            return
        }
        
        ArkDataManager.updateCurrency(aCell.currency)
        ArkActivityView.showMessage("Currency successfully updated!", style: .success)

        
        if let cells = tableView.visibleCells as? [CurrenctySelectionTableViewCell] {
            for cell in cells {
                if cell.currency == ArkDataManager.currentCurrency {
                    cell.currencySelected(true)
                } else {
                    cell.currencySelected(false)
                }
            }
        }
    }
}

// MARK: UITableViewDataSource
extension CurrencySelectionViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 31
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let aCell = cell as? CurrenctySelectionTableViewCell else {
            return
        }
        switch indexPath.row {
        case 0:
            aCell.update(.aud)
        case 1:
            aCell.update(.brl)
        case 2:
            aCell.update(.cad)
        case 3:
            aCell.update(.chf)
        case 4:
            aCell.update(.clp)
        case 5:
            aCell.update(.cny)
        case 6:
            aCell.update(.czk)
        case 7:
            aCell.update(.dkk)
        case 8:
            aCell.update(.eur)
        case 9:
            aCell.update(.gbp)
        case 10:
            aCell.update(.hkd)
        case 11:
            aCell.update(.huf)
        case 12:
            aCell.update(.idr)
        case 13:
            aCell.update(.ils)
        case 14:
            aCell.update(.inr)
        case 15:
            aCell.update(.jpy)
        case 16:
            aCell.update(.krw)
        case 17:
            aCell.update(.mxn)
        case 18:
            aCell.update(.myr)
        case 19:
            aCell.update(.nok)
        case 20:
            aCell.update(.nzd)
        case 21:
            aCell.update(.php)
        case 22:
            aCell.update(.pkr)
        case 23:
            aCell.update(.pln)
        case 24:
            aCell.update(.rub)
        case 25:
            aCell.update(.sek)
        case 26:
            aCell.update(.sgd)
        case 27:
            aCell.update(.thb)
        case 28:
            aCell.update(.twd)
        case 29:
            aCell.update(.usd)
        default:
            aCell.update(.zar)
        }
        
        if aCell.currency == ArkDataManager.tickerInfo?.currency {
            aCell.currencySelected(true)
        } else {
            aCell.currencySelected(false)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "currency") as? CurrenctySelectionTableViewCell
        if cell == nil {
            cell = CurrenctySelectionTableViewCell(style: .default, reuseIdentifier: "currency")
        }
        return cell!
    }
}
