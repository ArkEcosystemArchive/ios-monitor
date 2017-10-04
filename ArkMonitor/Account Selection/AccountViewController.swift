//
//  AccountViewController.swift
//  Dark
//
//  Created by Andrew on 2017-09-23.
//  Copyright © 2017 Walzy. All rights reserved.
//

import UIKit
import SwiftyArk

class AccountViewController: ArkViewController {
    
    private var gradientView : ArkGradientView!
    private var addressText  : ArkTextField!
    private var submitButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientView = ArkGradientView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(gradientTapped))
        gradientView.addGestureRecognizer(tap)
        view.addSubview(gradientView)
        gradientView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        let logoView = UIImageView(image: #imageLiteral(resourceName: "darkLogo"))
        view.addSubview(logoView)
        logoView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(_screenWidth * 0.7 / 3.0)
            make.centerX.equalToSuperview()
            make.top.equalTo(_screenHeight * 0.2)
        }
        
        let infoLabel       = UILabel()
        infoLabel.text      = "To get started,\nenter an Ark Address:"
        infoLabel.textColor = UIColor.white
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        infoLabel.numberOfLines = 2
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(50.0)
            make.top.equalTo(_screenHeight * 0.45)
        }
        
        submitButton = UIButton()
        submitButton.setTitleColor(UIColor.white, for: UIControlState())
        submitButton.setTitle("Submit", for: UIControlState())
        submitButton.backgroundColor = ArkPalette.accentColor
        submitButton.addTarget(self, action: #selector(submitbuttonTapped), for: .touchUpInside)
        view.addSubview(submitButton)
        submitButton.snp.makeConstraints { (make) in
            make.height.equalTo(45.0)
            make.width.equalTo(_screenWidth * 0.7)
            make.centerX.equalToSuperview()
            make.top.equalTo(_screenHeight * 0.8)
        }
        
        let spacer = UIView()
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(gradientTapped))
        spacer.addGestureRecognizer(tap1)
        view.addSubview(spacer)
        spacer.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(infoLabel.snp.bottom)
            make.bottom.equalTo(submitButton.snp.top)
        }
        
        addressText = ArkTextField(placeHolder: "Ark Address")
        addressText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        addressText.delegate = self
        spacer.addSubview(addressText)
        addressText.snp.makeConstraints { (make) in
            make.left.equalTo(25.0)
            make.right.equalToSuperview().offset(-25.0)
            make.height.equalTo(40.0)
            make.centerY.equalToSuperview().offset(-20.0)
        }
        testButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gradientView.startAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: .UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc private func didBecomeActive() {
        gradientView.startAnimation()
    }
    
    @objc func gradientTapped() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        let animationDuration =  getKeyboardAnimationDuration(notification)
        let animationCurve    = getKeyboardAnimationCurve(notification)
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animationDuration)
        UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: animationCurve.intValue)!)
        UIView.setAnimationBeginsFromCurrentState(true)
        view.frame.origin.y = -(_screenHeight * 0.25)
        UIView.commitAnimations()
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let animationDuration =  getKeyboardAnimationDuration(notification)
        let animationCurve    = getKeyboardAnimationCurve(notification)
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animationDuration)
        UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: animationCurve.intValue)!)
        UIView.setAnimationBeginsFromCurrentState(true)
        view.frame.origin.y = 0.0
        UIView.commitAnimations()
    }
    
    private func testButton() {
        guard let text = addressText.text else {
            disableButton()
            return
        }
        
        if text.count == 34 && (text.first == "A" || text.first == "D") {
            enableButton()
        } else {
            disableButton()
        }
    }
    
    private func disableButton() {
        submitButton.backgroundColor = ArkPalette.tertiaryBackgroundColor.withAlphaComponent(0.75)
        submitButton.isUserInteractionEnabled = false
    }
    
    private func enableButton() {
        submitButton.backgroundColor = ArkPalette.accentColor
        submitButton.isUserInteractionEnabled = true
    }
    
    @objc private func submitbuttonTapped() {
        addressText.endEditing(true)
        guard let address = addressText.text else {
            return
        }
        
        ArkDataManager.manager.account(address: address) { (error, account) in
            ArkActivityView.checkNetworkError(error)
            if let aError = error {
                if let bError = aError as? ApiError {
                    if bError != ApiError.networkError {
                        ArkActivityView.showMessage("Unable to find Account", style: .warning)
                    }
                } else {
                    ArkActivityView.showMessage("Unable to find Account", style: .warning)
                }
            }
            if let fetchAccount = account {
                ArkDataManager.registerWithAccount(fetchAccount)
                ArkActivityView.showMessage("Successfully found Account!", style: .success)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

// MARK: UITextFieldDelegate
extension AccountViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        testButton()
    }
}

extension AccountViewController {
    fileprivate func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        guard let infoKey  = notification.userInfo?[UIKeyboardFrameEndUserInfoKey],
            let rawFrame = (infoKey as AnyObject).cgRectValue else {
                return 0.0
        }
        let keyboardHeight = rawFrame.height
        return keyboardHeight
    }
    
    fileprivate func getKeyboardAnimationDuration(_ notification: Notification) -> Double {
        let userInfo : NSDictionary = notification.userInfo! as NSDictionary
        let keyBoardDuration = userInfo.value(forKey: UIKeyboardAnimationDurationUserInfoKey) as! Double
        return keyBoardDuration
    }
    
    fileprivate func getKeyboardAnimationCurve(_ notification: Notification) -> NSNumber {
        let userInfo : NSDictionary = notification.userInfo! as NSDictionary
        let keyboardCurve = userInfo.value(forKey: UIKeyboardAnimationCurveUserInfoKey) as! NSNumber
        return keyboardCurve
    }
}







