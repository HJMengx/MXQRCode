//
//  BatchInputView.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/7/1.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import SnapKit

let BatchInputViewHeight = 50

class BatchInputView: UIView {
    weak var titleLabel : UILabel!
    
    weak var inputField: MXTextField!

    init() {
        super.init(frame: CGRect.init())
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initSubviews() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        //
        let titleLabel = UILabel.init()
        self.titleLabel = titleLabel
        self.addSubview(self.titleLabel)
        self.titleLabel.textAlignment = .center
        self.titleLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(80)
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
        if self.titleLabel == nil {
            self.initSubviews()
        }
        self.titleLabel.text = title
        self.inputField.placeholder = placeHolder
    }
}
