//
//  SettingsViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 22/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

protocol SettingsProtocol: class {
    func onSettingsSaved()
}

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var serversPickerView: UIPickerView!
    @IBOutlet weak var ipAddressTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var sslEnabledSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!

    @IBOutlet weak var ipAddressTextFieldMarginTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var ipAddressTextFieldMarginBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var ipAddressTextFieldHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ipAddressSeparatorHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ipAddressLabelHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var portTextFieldMarginTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var portTextFieldMarginBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var portTextFieldHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var portSeparatorHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var portLabelHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var sslEnabledSwitchMarginTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var sslEnabledSwitchMarginBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var sslEnabledSwitchHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sslEnabledSeparatorHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sslEnabledLabelHeightConstraint: NSLayoutConstraint!

    var ipAddressTextFieldMarginTop: CGFloat = 0.0
    var ipAddressTextFieldMarginBottom: CGFloat = 0.0
    var ipAddressTextFieldHeight: CGFloat = 0.0
    var ipAddressSeparatorHeight: CGFloat = 0.0
    var ipAddressLabelHeight: CGFloat = 0.0

    var portTextFieldMarginTop: CGFloat = 0.0
    var portTextFieldMarginBottom: CGFloat = 0.0
    var portTextFieldHeight: CGFloat = 0.0
    var portSeparatorHeight: CGFloat = 0.0
    var portLabelHeight: CGFloat = 0.0

    var sslEnabledSwitchMarginTop: CGFloat = 0.0
    var sslEnabledSwitchMarginBottom: CGFloat = 0.0
    var sslEnabledSwitchHeight: CGFloat = 0.0
    var sslEnabledSeparatorHeight: CGFloat = 0.0
    var sslEnabledLabelHeight: CGFloat = 0.0

    weak var delegate: SettingsProtocol?
    var settings: Settings = Settings()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView          = UIImageView(image: #imageLiteral(resourceName: "whiteLogo"))

        
        customSaveButton()
        
        loadConstraints()

        usernameTextField.delegate = self
        ipAddressTextField.delegate = self
        portTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        loadSettings()
        adjustConstraints(isCustomServer: settings.serverType.hashValue == Server.custom.hashValue)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        
        return true
    }

    func loadConstraints() -> Void{
        ipAddressTextFieldMarginTop = ipAddressTextFieldMarginTopConstraint.constant
        ipAddressTextFieldMarginBottom = ipAddressTextFieldMarginBottomConstraint.constant
        ipAddressTextFieldHeight = ipAddressTextFieldHeightConstraint.constant
        ipAddressSeparatorHeight = ipAddressSeparatorHeightConstraint.constant
        ipAddressLabelHeight = ipAddressLabelHeightConstraint.constant
        
        portTextFieldMarginTop = portTextFieldMarginTopConstraint.constant
        portTextFieldMarginBottom = portTextFieldMarginBottomConstraint.constant
        portTextFieldHeight = portTextFieldHeightConstraint.constant
        portSeparatorHeight = portSeparatorHeightConstraint.constant
        portLabelHeight = portLabelHeightConstraint.constant
        
        sslEnabledSwitchMarginTop = sslEnabledSwitchMarginTopConstraint.constant
        sslEnabledSwitchMarginBottom = sslEnabledSwitchMarginBottomConstraint.constant
        sslEnabledSwitchHeight = sslEnabledSwitchHeightConstraint.constant
        sslEnabledSeparatorHeight = sslEnabledSeparatorHeightConstraint.constant
        sslEnabledLabelHeight = sslEnabledLabelHeightConstraint.constant
    }
    
    func adjustConstraints(isCustomServer : Bool) -> Void {

        if (isCustomServer) {

            ipAddressTextFieldMarginTopConstraint.constant = ipAddressTextFieldMarginTop
            ipAddressTextFieldMarginBottomConstraint.constant = ipAddressTextFieldMarginBottom
            ipAddressTextFieldHeightConstraint.constant = ipAddressTextFieldHeight
            ipAddressSeparatorHeightConstraint.constant = ipAddressSeparatorHeight
            ipAddressLabelHeightConstraint.constant = ipAddressLabelHeight
            
            portTextFieldMarginTopConstraint.constant = portTextFieldMarginTop
            portTextFieldMarginBottomConstraint.constant = portTextFieldMarginBottom
            portTextFieldHeightConstraint.constant = portTextFieldHeight
            portSeparatorHeightConstraint.constant = portSeparatorHeight
            portLabelHeightConstraint.constant = portLabelHeight
            
            sslEnabledSwitchMarginTopConstraint.constant = sslEnabledSwitchMarginTop
            sslEnabledSwitchMarginBottomConstraint.constant = sslEnabledSwitchMarginBottom
            sslEnabledSwitchHeightConstraint.constant = sslEnabledSwitchHeight
            sslEnabledSeparatorHeightConstraint.constant = sslEnabledSeparatorHeight
            sslEnabledLabelHeightConstraint.constant = sslEnabledLabelHeight
            
            sslEnabledSwitch.isHidden = false

        } else {
            ipAddressTextFieldMarginTopConstraint.constant = 0
            ipAddressTextFieldMarginBottomConstraint.constant = 0
            ipAddressTextFieldHeightConstraint.constant = 0
            ipAddressSeparatorHeightConstraint.constant = 0
            ipAddressLabelHeightConstraint.constant = 0
            
            portTextFieldMarginTopConstraint.constant = 0
            portTextFieldMarginBottomConstraint.constant = 0
            portTextFieldHeightConstraint.constant = 0
            portSeparatorHeightConstraint.constant = 0
            portLabelHeightConstraint.constant = 0
            
            sslEnabledSwitchMarginTopConstraint.constant = 0
            sslEnabledSwitchMarginBottomConstraint.constant = 0
            sslEnabledSwitchHeightConstraint.constant = 0
            sslEnabledSeparatorHeightConstraint.constant = 0
            sslEnabledLabelHeightConstraint.constant = 0

            sslEnabledSwitch.isHidden = true
        }
    }
    
    func loadSettings() -> Void {
        settings = Settings.getSettings()
        if (settings.isValid()) {
            usernameTextField.text = settings.username
            
            if (settings.serverType == Server.custom) {
                ipAddressTextField.text = settings.ipAddress
                portTextField.text = String(settings.port)
            }

            sslEnabledSwitch.setOn(settings.sslEnabled, animated: true)

            serversPickerView.selectRow(settings.serverType.hashValue, inComponent: 0, animated: true)
            
        }
    }
    
    func customSaveButton() -> Void {
        saveButton.backgroundColor = ArkColors.blue
    }

    @IBAction func saveAction(_ sender: Any) {
        guard Reachability.isConnectedToNetwork() == true else {
            ArkActivityView.showMessage("Please connect to internet.")
            return
        }

        let username = usernameTextField.text
        let ipAddress = ipAddressTextField.text
        let port = portTextField.text
        let sslEnabled = sslEnabledSwitch.isOn
        let serverId = serversPickerView.selectedRow(inComponent: 0)
 
        let settings = Settings()

        if (!Utils.validateUsername(username: username!)) {
            ArkActivityView.showMessage("Username invalid.")
            return
        }
        
        settings.username = username!

        if (serverId == Server.custom.hashValue) {
            if (!Utils.validateIpAddress(ipAddress: ipAddress!)) {
                ArkActivityView.showMessage("Ip Address invalid.")
                return
            }

            if (!Utils.validatePortStr(portStr: port!)) {
                ArkActivityView.showMessage("Port invalid.")
                return
            }
            
            settings.ipAddress = ipAddress!
            settings.port = Int(port!)!
            settings.sslEnabled = sslEnabled
        }

        settings.setServerType(serverType: Server(rawValue: serverId)!)
        
        ArkActivityView.startAnimating()
        
        ArkService.sharedInstance.requestDelegate(settings: settings, listener: RequestData(myClass: self))
    }

}


extension SettingsViewController : UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == serversPickerView) {
            return Server.count
        }

        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == serversPickerView) {
            let server = Server(rawValue: row)
            
            let isCustomServersCustomServer = server?.hashValue == Server.custom.hashValue

            adjustConstraints(isCustomServer:isCustomServersCustomServer)
            
            if (isCustomServersCustomServer) {
                sslEnabledSwitch.setOn(false, animated: false)
            } else {
                ipAddressTextField.text = ""
                portTextField.text = ""
                sslEnabledSwitch.setOn(true, animated: false)
            }
        }
        
    }

}

extension SettingsViewController : UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard pickerView == serversPickerView else {
            return nil
        }
        
        return Server(rawValue: row)?.description
    }
    
}


private class RequestData: RequestListener {
    let selfReference: SettingsViewController
    
    init(myClass: SettingsViewController){
        selfReference = myClass
    }
    
    public func onFailure(e: Error) -> Void {
        ArkActivityView.showMessage("Unable to retrieve data. Please try again later.")
        ArkActivityView.stopAnimating()
    }
    
    func onResponse(object: Any)  -> Void {

        if let delegate = object as? Delegate {

            let settings = Settings.getSettings()

            let username = selfReference.usernameTextField.text
            let ipAddress = selfReference.ipAddressTextField.text
            let port = selfReference.portTextField.text
            let sslEnabled = selfReference.sslEnabledSwitch.isOn
            let serverId = selfReference.serversPickerView.selectedRow(inComponent: 0)

            settings.username = username!
            settings.sslEnabled = sslEnabled
            settings.setServerType(serverType: Server(rawValue: serverId)!)

            if (Utils.validateIpAddress(ipAddress: ipAddress!)) {
                settings.ipAddress = ipAddress!
            }
            
            if (Utils.validatePortStr(portStr: port!)) {
                settings.port = Int(port!)!
            }

            settings.arkAddress = delegate.address
            settings.publicKey = delegate.publicKey
            
            selfReference.settings = settings

            Settings.saveSettings(settings: settings)

            if (selfReference.delegate == nil) {
                //let navController = UINavigationController(rootViewController: HomeViewController())
                //selfReference.slideMenuController()?.changeMainViewController(navController, close: true)
                
            } else {
                selfReference.delegate?.onSettingsSaved()
            }
            
        }
        
        ArkActivityView.stopAnimating()
    }
}
