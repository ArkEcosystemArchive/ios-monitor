//
//  SettingsViewController.swift
//  ArkMonitor
//
//  Created by Victor Lins on 22/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit
import Toaster
import ESPullToRefresh
import NVActivityIndicatorView

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

        self.navigationItem.title = "Settings"
        
        setNavigationBarItem()
        
        customSaveButton()
        
        loadConstraints()

        self.usernameTextField.delegate = self
        self.ipAddressTextField.delegate = self
        self.portTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        loadSettings()
        adjustConstraints(isCustomServer: self.settings.serverType.hashValue == Server.custom.hashValue)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        
        return true
    }

    func loadConstraints() -> Void{
        self.ipAddressTextFieldMarginTop = self.ipAddressTextFieldMarginTopConstraint.constant
        self.ipAddressTextFieldMarginBottom = self.ipAddressTextFieldMarginBottomConstraint.constant
        self.ipAddressTextFieldHeight = self.ipAddressTextFieldHeightConstraint.constant
        self.ipAddressSeparatorHeight = self.ipAddressSeparatorHeightConstraint.constant
        self.ipAddressLabelHeight = self.ipAddressLabelHeightConstraint.constant
        
        self.portTextFieldMarginTop = self.portTextFieldMarginTopConstraint.constant
        self.portTextFieldMarginBottom = self.portTextFieldMarginBottomConstraint.constant
        self.portTextFieldHeight = self.portTextFieldHeightConstraint.constant
        self.portSeparatorHeight = self.portSeparatorHeightConstraint.constant
        self.portLabelHeight = self.portLabelHeightConstraint.constant
        
        self.sslEnabledSwitchMarginTop = self.sslEnabledSwitchMarginTopConstraint.constant
        self.sslEnabledSwitchMarginBottom = self.sslEnabledSwitchMarginBottomConstraint.constant
        self.sslEnabledSwitchHeight = self.sslEnabledSwitchHeightConstraint.constant
        self.sslEnabledSeparatorHeight = self.sslEnabledSeparatorHeightConstraint.constant
        self.sslEnabledLabelHeight = self.sslEnabledLabelHeightConstraint.constant
    }
    
    func adjustConstraints(isCustomServer : Bool) -> Void {

        if (isCustomServer) {

            self.ipAddressTextFieldMarginTopConstraint.constant = self.ipAddressTextFieldMarginTop
            self.ipAddressTextFieldMarginBottomConstraint.constant = self.ipAddressTextFieldMarginBottom
            self.ipAddressTextFieldHeightConstraint.constant = self.ipAddressTextFieldHeight
            self.ipAddressSeparatorHeightConstraint.constant = self.ipAddressSeparatorHeight
            self.ipAddressLabelHeightConstraint.constant = self.ipAddressLabelHeight
            
            self.portTextFieldMarginTopConstraint.constant = self.portTextFieldMarginTop
            self.portTextFieldMarginBottomConstraint.constant = self.portTextFieldMarginBottom
            self.portTextFieldHeightConstraint.constant = self.portTextFieldHeight
            self.portSeparatorHeightConstraint.constant = self.portSeparatorHeight
            self.portLabelHeightConstraint.constant = self.portLabelHeight
            
            self.sslEnabledSwitchMarginTopConstraint.constant = self.sslEnabledSwitchMarginTop
            self.sslEnabledSwitchMarginBottomConstraint.constant = self.sslEnabledSwitchMarginBottom
            self.sslEnabledSwitchHeightConstraint.constant = self.sslEnabledSwitchHeight
            self.sslEnabledSeparatorHeightConstraint.constant = self.sslEnabledSeparatorHeight
            self.sslEnabledLabelHeightConstraint.constant = self.sslEnabledLabelHeight
            
            self.sslEnabledSwitch.isHidden = false

        } else {
            self.ipAddressTextFieldMarginTopConstraint.constant = 0
            self.ipAddressTextFieldMarginBottomConstraint.constant = 0
            self.ipAddressTextFieldHeightConstraint.constant = 0
            self.ipAddressSeparatorHeightConstraint.constant = 0
            self.ipAddressLabelHeightConstraint.constant = 0
            
            self.portTextFieldMarginTopConstraint.constant = 0
            self.portTextFieldMarginBottomConstraint.constant = 0
            self.portTextFieldHeightConstraint.constant = 0
            self.portSeparatorHeightConstraint.constant = 0
            self.portLabelHeightConstraint.constant = 0
            
            self.sslEnabledSwitchMarginTopConstraint.constant = 0
            self.sslEnabledSwitchMarginBottomConstraint.constant = 0
            self.sslEnabledSwitchHeightConstraint.constant = 0
            self.sslEnabledSeparatorHeightConstraint.constant = 0
            self.sslEnabledLabelHeightConstraint.constant = 0

            self.sslEnabledSwitch.isHidden = true
        }
    }
    
    func loadSettings() -> Void {
        self.settings = Settings.getSettings()
        if (self.settings.isValid()) {
            usernameTextField.text = self.settings.username
            
            if (settings.serverType == Server.custom) {
                ipAddressTextField.text = self.settings.ipAddress
                portTextField.text = String(self.settings.port)
            }

            sslEnabledSwitch.setOn(self.settings.sslEnabled, animated: true)

            serversPickerView.selectRow(self.settings.serverType.hashValue, inComponent: 0, animated: true)
            
        }
    }
    
    func customSaveButton() -> Void {
        self.saveButton.backgroundColor = UIColor(hex: "1E88E5")
    }

    @IBAction func saveAction(_ sender: Any) {
        if (!Reachability.isConnectedToNetwork()) {
            Toast(text: "Please connect to internet.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            
            return
        }

        let username = self.usernameTextField.text
        let ipAddress = self.ipAddressTextField.text
        let port = self.portTextField.text
        let sslEnabled = self.sslEnabledSwitch.isOn
        let serverId = self.serversPickerView.selectedRow(inComponent: 0)
 
        let settings = Settings()

        if (!Utils.validateUsername(username: username!)) {
            Toast(text: "Username invalid.",
                  delay: Delay.short,
                  duration: Delay.long).show()
            
            return
        }
        
        settings.username = username!

        if (serverId == Server.custom.hashValue) {
            if (!Utils.validateIpAddress(ipAddress: ipAddress!)) {
                Toast(text: "Ip Address invalid.",
                      delay: Delay.short,
                      duration: Delay.long).show()
                
                return
            }

            if (!Utils.validatePortStr(portStr: port!)) {
                Toast(text: "Port invalid.",
                      delay: Delay.short,
                      duration: Delay.long).show()
                
                return
            }
            
            settings.ipAddress = ipAddress!
            settings.port = Int(port!)!
            settings.sslEnabled = sslEnabled
        }

        settings.setServerType(serverType: Server(rawValue: serverId)!)

        let activityData = ActivityData(type: NVActivityIndicatorType.lineScale)
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        ArkService.sharedInstance.requestDelegate(settings: settings, listener: RequestData(myClass: self))
    }

}


extension SettingsViewController : UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == self.serversPickerView) {
            return Server.count
        }

        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == self.serversPickerView) {
            let server = Server(rawValue: row)
            
            let isCustomServersCustomServer = server?.hashValue == Server.custom.hashValue

            adjustConstraints(isCustomServer:isCustomServersCustomServer)
            
            if (isCustomServersCustomServer) {
                self.sslEnabledSwitch.setOn(false, animated: false)
            } else {
                self.ipAddressTextField.text = ""
                self.portTextField.text = ""
                self.sslEnabledSwitch.setOn(true, animated: false)
            }
        }
        
    }

}

extension SettingsViewController : UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == self.serversPickerView) {
            return Server(rawValue: row)?.description
        }

        return ""
        
    }
    
}


private class RequestData: RequestListener {
    let selfReference: SettingsViewController
    
    init(myClass: SettingsViewController){
        selfReference = myClass
    }
    
    public func onFailure(e: Error) -> Void {
        Toast(text: "Unable to retrieve data. Please try again later.",
              delay: Delay.short,
              duration: Delay.long).show()
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    func onResponse(object: Any)  -> Void {

        if let delegate = object as? Delegate {

            let settings = Settings.getSettings()

            let username = self.selfReference.usernameTextField.text
            let ipAddress = self.selfReference.ipAddressTextField.text
            let port = self.selfReference.portTextField.text
            let sslEnabled = self.selfReference.sslEnabledSwitch.isOn
            let serverId = self.selfReference.serversPickerView.selectedRow(inComponent: 0)

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
            
            self.selfReference.settings = settings

            Settings.saveSettings(settings: settings)

            if (self.selfReference.delegate == nil) {
                let navController = UINavigationController(rootViewController: HomeViewController())
                self.selfReference.slideMenuController()?.changeMainViewController(navController, close: true)
                
            } else {
                self.selfReference.delegate?.onSettingsSaved()
            }
            
        }
        
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
