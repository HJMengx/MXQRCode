//
//  HistoryCell.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/27.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import SnapKit

let HistoryCellHeight = 64

class HistoryCell: UIView {

    weak var numberOfCountLabel : UILabel!
    
    weak var imgViewForTitle : UIImageView!
    
    var isIcon : Bool = false
    
    weak var titleLabel : UILabel!
    
    convenience init(isIcon: Bool) {
        self.init(frame: CGRect())
        // Other Initialize
        self.isIcon = isIcon
        self.initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initSubviews() {
        if self.isIcon {
            let iconView = UIImageView()
            self.imgViewForTitle = iconView
            self.addSubview(self.imgViewForTitle)
            self.imgViewForTitle.snp.makeConstraints { (make: ConstraintMaker) in
                make.left.equalToSuperview().offset(5)
                make.width.equalTo(32)
                make.top.equalToSuperview().offset(5)
                make.height.equalTo(32)
            }
        } else {
            let numberLabel = UILabel()
            self.numberOfCountLabel = numberLabel
            self.addSubview(self.numberOfCountLabel)
            self.numberOfCountLabel.font = UIFont.systemFont(ofSize: 24)
            self.numberOfCountLabel.textAlignment = .center
            self.numberOfCountLabel.snp.makeConstraints { (make: ConstraintMaker) in
                make.left.equalToSuperview().offset(5)
                make.right.equalToSuperview().offset(-5)
                make.top.equalToSuperview().offset(5)
                make.height.equalTo(32)
            }
        }
        // title
        let titleLabel = UILabel()
        self.titleLabel = titleLabel
        self.addSubview(self.titleLabel)
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.systemFont(ofSize: 13)
        self.titleLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.width.equalToSuperview().offset(-10)
            if self.isIcon {
                make.centerX.equalTo(self.imgViewForTitle.snp.centerX)
                make.top.equalTo(self.imgViewForTitle.snp.bottom).offset(15)
            } else {
                make.centerX.equalTo(self.numberOfCountLabel.snp.centerX)
                make.top.equalTo(self.numberOfCountLabel.snp.bottom).offset(15)
            }
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func settingAtrribute(title: String, other: String) {
        if isIcon {
            self.imgViewForTitle.image = UIImage.init(named: other)
        } else {
            self.numberOfCountLabel.text = other
        }
        self.titleLabel.text = title
    }
}
