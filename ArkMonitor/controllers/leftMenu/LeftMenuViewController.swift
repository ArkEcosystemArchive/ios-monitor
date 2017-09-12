//
//  LeftMenuViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 22/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    case home = 0
    case forgedBlocks
    case latestTransactions
    case peers
    case delegates
    case votesMade
    case votesReceived
    case settings
}

protocol LeftMenuProtocol : class {
    func changeViewController(menu: LeftMenu)
}

class LeftMenuViewController: UIViewController, SettingsProtocol {
    var menus = ["Home", "Forged Blocks", "Latest Transactions", "Peers",
                 "Delegates", "Votes", "Voters", "Settings"]
    
    @IBOutlet weak var tableView: UITableView!
    
    var homeViewController: HomeViewController!
    var forgedBlocksViewController: ForgedBlocksViewController!
    var latestTransactionsViewController: LatestTransactionsViewController!
    var peersViewController: PeersViewController!
    var delegatesViewController: DelegateViewController!
    var votesMadeViewController: VotesViewController!
    var votesReceivedViewController: VotersViewController!
    var settingsViewController: SettingsViewController!
    
    @IBOutlet weak var imageHeaderView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.homeViewController = HomeViewController()
        self.forgedBlocksViewController = ForgedBlocksViewController()
        self.latestTransactionsViewController = LatestTransactionsViewController()
        self.peersViewController = PeersViewController()
        self.delegatesViewController = DelegateViewController()
        self.votesMadeViewController = VotesViewController()
        self.votesReceivedViewController = VotersViewController()
        self.settingsViewController = SettingsViewController()
        self.settingsViewController.delegate = self

        self.tableView.registerCellNib(DataTableViewCell.self)

        customImageHeader()
    }

    func onSettingsSaved() {
        let navController = UINavigationController(rootViewController: self.homeViewController!)
        self.slideMenuController()?.changeMainViewController(navController, close: true)
    }


    func customImageHeader() {
        self.imageHeaderView.layoutIfNeeded()
        self.imageHeaderView.layer.cornerRadius = self.imageHeaderView.bounds.size.height / 2
        self.imageHeaderView.clipsToBounds = true
    }

    func changeViewController(menu: LeftMenu) {
        var viewController: UIViewController? = nil
        
        switch menu {
        case .home:
            viewController = self.homeViewController
            break
        case .forgedBlocks:
            viewController = self.forgedBlocksViewController
            break
        case .latestTransactions:
            viewController = self.latestTransactionsViewController
            break
        case .peers:
            viewController = self.peersViewController
            break
        case .delegates:
            viewController = self.delegatesViewController
            break
        case .votesMade:
            viewController = self.votesMadeViewController
            break
        case .votesReceived:
            viewController = self.votesReceivedViewController
            break
        case .settings:
            viewController = self.settingsViewController
            break
        }

        if (viewController != nil) {
            let navController = UINavigationController(rootViewController: viewController!)
            self.slideMenuController()?.changeMainViewController(navController, close: true)
        }
        
    }

}

extension LeftMenuViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DataTableViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu: menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension LeftMenuViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.identifier, for: indexPath) as! DataTableViewCell

        var image: UIImage? = nil

        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .home:
                image = UIImage (named: "ic_home_black_36dp")
                break
            case .forgedBlocks:
                image = UIImage (named: "ic_history_black_36dp")
                break
            case .latestTransactions:
                image = UIImage (named: "ic_compare_arrows_black_36dp")
                break
            case .peers:
                image = UIImage (named: "ic_network_check_black_36dp")
                break
            case .delegates:
                image = UIImage (named: "ic_group_black_36dp")
                break
            case .votesMade:
                image = UIImage (named: "ic_call_made_black_36dp")
                break
            case .votesReceived:
                image = UIImage (named: "ic_call_received_black_36dp")
                break
            case .settings:
                image = UIImage (named: "ic_settings_black_36dp")
                break
            }
        }

        if (image != nil) {
            let dataTable = DataTableViewCellData(image: image!, text: menus[indexPath.row])
            cell.setData(dataTable)
        }

        return cell
    }

}
