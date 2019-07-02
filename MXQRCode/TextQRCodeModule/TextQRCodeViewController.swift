//
//  TextQRCodeViewController.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/28.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class TextQRCodeViewController: GenerateBaseViewController {
    
    weak var textView: MXTextView!
    
    weak var generateButton : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "文本"
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(TextQRCodeViewController.dismissKeyBoard)))
        self.initSubviews()
    }
    
    private func initSubviews() {
        let textView = MXTextView.init()
        self.textView = textView
        self.view.addSubview(self.textView)
        self.textView.textAlignment = .left
        self.textView.layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        self.textView.layer.borderWidth = 0.5
        self.textView.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(TopHeight + 5)
            make.height.equalTo(140)
        }
        // Generate Button
        let generateBtn = UIButton.init()
        self.generateButton = generateBtn
        self.view.addSubview(self.generateButton)
        self.generateButton.addTarget(self, action: #selector(TextQRCodeViewController.geenrateQRCode), for: UIControl.Event.touchUpInside)
        self.generateButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.generateButton.backgroundColor = MainColor
        self.generateButton.titleLabel?.textAlignment = .center
        self.generateButton.layer.cornerRadius = 5
        self.generateButton.layer.masksToBounds = true
        self.generateButton.setTitle("生成二维码", for: UIControl.State.normal)
        self.generateButton.snp.makeConstraints { (make:ConstraintMaker) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(self.textView.snp.bottom).offset(5)
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
        MXManager.sharedInstance.createGenerateQRCodeVC(parameters: ["content": text, "dotColor": CIColor.init(color: UIColor.white), "backgroundColor": CIColor.init(color: UIColor.black)]) { (generatedVC: GeneratedViewController?) in
            if generatedVC == nil {
                SVProgressHUD.showError(withStatus: "出现未知错误, 请重试")
            } else {
                self.navigationController?.pushViewController(generatedVC!, animated: true)
            }
        }
    }
    
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    
    @objc func initAttributes(params: [String: Any]) -> TextQRCodeViewController {
        
        return self
    }

}
