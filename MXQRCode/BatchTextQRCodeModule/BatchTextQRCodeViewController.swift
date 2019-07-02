//
//  BatchTextQRCodeViewController.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/30.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class BatchTextQRCodeViewController: GenerateBaseViewController {
    
    weak var textView : MXTextView!
    
    weak var batchInputMinView : BatchInputView!
    
    weak var batchInputMaxView : BatchInputView!
    
    weak var batchInputSplitView : BatchInputView!
    
    weak var generateButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "批量文本生成"
        
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(BatchTextQRCodeViewController.dismissKeyBoard)))
        
        self.initSubviews()
    }
    
    private func initSubviews() {
        // minInput
        let minInput = BatchInputView.init()
        self.view.addSubview(minInput)
        minInput.snp.makeConstraints { (make:ConstraintMaker) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(TopHeight + 5)
            make.height.equalTo(BatchInputViewHeight)
        }
        minInput.settingAttributes(title: "最小值", placeHolder: "请输入生成范围的最小值")
        self.batchInputMinView = minInput
        // maxInput
        let maxInput = BatchInputView.init()
        self.view.addSubview(maxInput)
        maxInput.snp.makeConstraints { (make:ConstraintMaker) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(self.batchInputMinView.snp.bottom).offset(5)
            make.height.equalTo(BatchInputViewHeight)
        }
        maxInput.settingAttributes(title: "最大值", placeHolder: "请输入生成范围的最大值")
        self.batchInputMaxView = maxInput
        // text
        let textView = MXTextView.init()
        self.textView = textView
        self.view.addSubview(self.textView)
        self.textView.textAlignment = .left
        self.textView.layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        self.textView.layer.borderWidth = 0.5
        self.textView.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(self.batchInputMaxView.snp.bottom).offset(10)
            make.height.equalTo(80)
        }
        // splitInput
        let splitInput = BatchInputView.init()
        self.view.addSubview(splitInput)
        splitInput.snp.makeConstraints { (make:ConstraintMaker) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(self.textView.snp.bottom).offset(5)
            make.height.equalTo(BatchInputViewHeight)
        }
        splitInput.settingAttributes(title: "分割符号", placeHolder: "请输入粘贴文本的分隔符")
        self.batchInputSplitView = splitInput
        // Generate Button
        let generateBtn = UIButton.init()
        self.generateButton = generateBtn
        self.view.addSubview(self.generateButton)
        self.generateButton.addTarget(self, action: #selector(BatchTextQRCodeViewController.geenrateQRCode), for: UIControl.Event.touchUpInside)
        self.generateButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.generateButton.backgroundColor = MainColor
        self.generateButton.titleLabel?.textAlignment = .center
        self.generateButton.layer.cornerRadius = 5
        self.generateButton.layer.masksToBounds = true
        self.generateButton.setTitle("生成二维码", for: UIControl.State.normal)
        self.generateButton.snp.makeConstraints { (make:ConstraintMaker) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(self.batchInputSplitView.snp.bottom).offset(5)
            make.height.equalTo(40)
        }
    }
    @objc func geenrateQRCode() {
        guard let text = self.textView.text else {
            SVProgressHUD.showError(withStatus: "您没有输入任何信息")
            return
        }
        
        if text.count <= 0 || text == "" {
            SVProgressHUD.showInfo(withStatus: "请输入信息且不要只输入空格或者回车")
        }
        //  Navigate to generate Page if success
        
    }
    
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    

    @objc func initAttributes(params: [String: Any]) -> BatchTextQRCodeViewController {
        
        return self
    }
}
