//
//  SettingsServerTableViewCell.swift
//  ArkMonitor
//
//  Created by Andrew on 2017-09-13.
//  Copyright © 2017 vrlc92. All rights reserved.
//

import UIKit

protocol SettingsServerTableViewCellDelegate: class {
    func serverCell(_ cell: SettingsServerTableViewCell, didChangeMode mode: ServerMode)
}

class SettingsServerTableViewCell: UITableViewCell {
    
    public weak var delegate: SettingsServerTableViewCellDelegate?

    var nameLabel    : UILabel!
    var serverPicker : UIPickerView!
    
    init(_ mode: ServerMode) {
        super.init(style: .default, reuseIdentifier: "server")
        
        backgroundColor = UIColor.white
        
        let nameLabel           = UILabel()
        nameLabel.text          = "Server"
        nameLabel.textColor     = ArkColors.darkGray
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 16.0)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(25.0)
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        
        serverPicker            = UIPickerView()
        serverPicker.dataSource = self
        serverPicker.delegate   = self
        
        addSubview(serverPicker)
        serverPicker.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-25.0)
            make.width.equalToSuperview().multipliedBy(0.65)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateMode(_ mode: ServerMode) {
        switch mode {
        case .node1:
            serverPicker.selectRow(0, inComponent: 0, animated: false)
        case .node2:
            serverPicker.selectRow(1, inComponent: 0, animated: false)
        default:
            serverPicker.selectRow(2, inComponent: 0, animated: false)
        }
    }
}

// MARK: UIPickerViewDelegate
extension SettingsServerTableViewCell : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        
        switch row {
        case 0:
            label.text = "node1.arknet.cloud"
        case 1:
            label.text = "node2.arknet.cloud"
        default:
            label.text = "custom"
        }
        
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textColor = ArkColors.blue
        label.adjustsFontSizeToFitWidth = true
        return label
    }
}


// MARK: UIPickerViewDataSource
extension SettingsServerTableViewCell : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            delegate?.serverCell(self, didChangeMode: .node1)
        case 1:
            delegate?.serverCell(self, didChangeMode: .node2)
        default:
            delegate?.serverCell(self, didChangeMode: .custom)
        }
    }
}

