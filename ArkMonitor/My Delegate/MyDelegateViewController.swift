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

class MyDelegateViewController: ArkViewController {

    public var delegate       : Delegate?
    fileprivate var tableView : ArkTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myDelegate = ArkDataManager.currentVote {
            delegate = myDelegate
        }
        
        navigationItem.title = delegate?.username ?? "Delegate"
        
        tableView = ArkTableView(CGRect.zero)
        tableView.delegate       = self
        tableView.dataSource     = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let myDelegate = ArkDataManager.currentVote {
            delegate = myDelegate
        } else {
            delegate = nil
            ArkActivityView.showMessage(NSLocalizedString("Message.NoDelegateForAccount", comment: ""), style: .warning)
        }
        tableView.reloadData()
        navigationItem.title = delegate?.username ?? "Delegate"
    }
}

// MARK: UITableViewDelegate
extension MyDelegateViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 35.0))
        headerView.backgroundColor = ArkPalette.secondaryBackgroundColor
        
        let headerLabel = UILabel(frame: CGRect(x: 12.5, y: 0.0, width: _screenWidth - 12.5, height: 35.0))
        headerLabel.textColor = ArkPalette.highlightedTextColor
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  .semibold)
                
        switch section {
        case 0:
            headerLabel.text = NSLocalizedString("Delegates.Address", comment: "")
        case 1:
            headerLabel.text = NSLocalizedString("Delegates.PublicKey", comment: "")
        case 2:
            headerLabel.text = NSLocalizedString("Delegates.Votes", comment: "")
        case 3:
            headerLabel.text = NSLocalizedString("Delegates.ProducedBlocks", comment: "")
        case 4:
            headerLabel.text = NSLocalizedString("Delegates.MissedBlocks", comment: "")
        case 5:
            headerLabel.text = NSLocalizedString("Delegates.Rank", comment: "")
        case 6:
            headerLabel.text = NSLocalizedString("Delegates.Productivity", comment: "")
        default:
            headerLabel.text = NSLocalizedString("Delegates.Approval", comment: "")
        }
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 65.0
        }
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
}

// MARK: UITableViewDelegate
extension MyDelegateViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var titleString   = ""
        var numberOfLines = 1
        
        switch indexPath.section {
        case 0:
            titleString = delegate?.address ?? ""
        case 1:
            titleString = delegate?.publicKey ?? ""
            numberOfLines = 2
        case 2:
            titleString = String(delegate?.votes ?? 0.0)
        case 3:
            titleString = String(delegate?.producedblocks ?? 0)
        case 4:
            titleString = String(delegate?.missedblocks ?? 0)
        case 5:
            titleString = String(delegate?.rate ?? 0)
        case 6:
            titleString = String(delegate?.productivity ?? 0.0) + "%"
        default:
            titleString = String(delegate?.approval ?? 0.0) + "%"
        }
        
        let cell = ArkDetailTableViewCell(titleString, numberOfLines: numberOfLines)
        return cell
    }
}

