//
//  ToolItem.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/26.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import SnapKit

let ToolItemHeight : CGFloat = 60

let ToolItemWidth : CGFloat = 60

class ToolItem: UIView {

    weak var itemIcon : UIImageView!
    
    weak var itemName : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initSubviews() {
        let itemImage = UIImageView.init()
        self.addSubview(itemImage)
        self.itemIcon = itemImage
        self.itemIcon.backgroundColor = MainColor
        self.itemIcon.snp.makeConstraints { (make: ConstraintMaker) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
        // ItemName
        let itemLabel = UILabel()
        self.addSubview(itemLabel)
        self.itemName = itemLabel
        self.itemName.font = UIFont.systemFont(ofSize: 12)
        self.itemName.textAlignment = .center
        self.itemName.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.equalTo(self.itemIcon.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(8)
        }
    }
    
    func settingAttributes(imageName: String, itemText: String) {
        self.itemIcon.image = UIImage.init(named: imageName)
        self.itemName.text = itemText
    }
}
