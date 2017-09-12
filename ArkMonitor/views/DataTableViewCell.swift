//
//  DataTableViewCell.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/8/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

struct DataTableViewCellData {
    
    init(image: UIImage, text: String) {
        self.image = image
        self.text = text
    }
    var image: UIImage
    var text: String
}

class DataTableViewCell : BaseTableViewCell {
    
    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var dataText: UILabel!
    
    override func awakeFromNib() {
        self.dataText?.font = UIFont.italicSystemFont(ofSize: 16)
        self.dataText?.textColor = ArkColors.gray
    }
 
    override class func height() -> CGFloat {
        return 60
    }

    override func setData(_ data: Any?) {
        if let data = data as? DataTableViewCellData {
            self.dataImage.image = data.image
            self.dataText.text = data.text
        }
    }
}
