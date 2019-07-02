//
//  CardQRCodeCell.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/29.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import SnapKit


let CardQRCodeCellIdentifier = "CardQRCodeCell"

let CardQRCodeCellHeight = 50

class CardQRCodeCell: UITableViewCell {

    weak var titleLabel : UILabel!
    
    weak var inputField: MXTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initSubviews() {
        let titleLabel = UILabel.init()
        self.titleLabel = titleLabel
        self.addSubview(self.titleLabel)
        self.titleLabel.textAlignment = .center
        self.titleLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(60)
        }
        // input
        let inputField = MXTextField.init()
        self.inputField = inputField
        self.addSubview(self.inputField)
        self.inputField.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.equalTo(self.titleLabel.snp.right).offset(10)
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func settingAttributes(title: String, placeHolder: String) {
        self.titleLabel.text = title
        self.inputField.placeholder = placeHolder
        
        if title.contains("电话") {
            self.inputField.keyboardType = .numberPad
            self.inputField.maxLength = 11
        } else if title.contains("邮箱") {
            self.inputField.keyboardType = .emailAddress
        }
    }
}
