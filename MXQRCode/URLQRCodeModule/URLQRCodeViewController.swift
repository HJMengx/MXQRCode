//
//  URLQRCodeViewController.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/30.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

private let preInputs = ["http://", "https://", "www.", ".com", ".cn", "粘贴"]

class URLQRCodeViewController: GenerateBaseViewController {

    weak var textView: UITextView!
    
    weak var generateButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "网址"
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(TextQRCodeViewController.dismissKeyBoard)))
        
        self.initSubviews()
    }
    
    private func initSubviews() {
        let textView = UITextView.init()
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
        
        // Contaniner
        let container = self.initPreButtons()
        
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
            make.top.equalTo(container.snp.bottom).offset(5)
            make.height.equalTo(40)
        }
    }
    
    private func initPreButtons() -> UIView {
        // Base params
        let numberOfRow = 4
        let numberOfWidth = 60
        let numberOfHeight = 35
        let gap = (self.view.frame.width - 10.0 - CGFloat(4 * numberOfWidth)) / CGFloat(numberOfRow - 1)
        let colGap: CGFloat = 15
        // container
        let containerView = UIView.init()
        self.view.addSubview(containerView)
        containerView.backgroundColor = self.view.backgroundColor
        containerView.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(self.textView.snp.bottom).offset(10)
            make.height.equalTo(CGFloat(2 * numberOfHeight) + colGap)
        }
        // Buttons
        for index in 0..<preInputs.count {
            var x : CGFloat = 0
            var y : CGFloat = 0
            
            let position = index % numberOfRow
            
            if position != 0 {
                x = CGFloat(position) * (CGFloat(numberOfWidth) + gap)
            }
            
            if index >= numberOfRow {
                y = colGap + CGFloat(numberOfHeight)
            }
            let itemBtn = UIButton.init(frame: CGRect.init(x: x, y: y, width: CGFloat(numberOfWidth), height: CGFloat(numberOfHeight)))
            itemBtn.addTarget(self, action: #selector(URLQRCodeViewController.preButtonClicked(sender:)), for: UIControl.Event.touchUpInside)
            itemBtn.setTitle(preInputs[index], for: UIControl.State.normal)
            itemBtn.titleLabel?.textAlignment = .center
            itemBtn.backgroundColor = UIColor.white
            itemBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            itemBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            itemBtn.layer.cornerRadius = 5
            itemBtn.layer.masksToBounds = true
            containerView.addSubview(itemBtn)
        }
        
        return containerView
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
    
    @objc func preButtonClicked(sender: UIButton) {
        guard let title = sender.currentTitle else {
            return
        }
        if title.contains("粘贴") {
            self.textView.text = String.init(format: "%@%@", self.textView.text, UIPasteboard.general.string ?? "")
        } else {
            self.textView.text = String.init(format: "%@%@", self.textView.text, title)
        }
    }
    
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    
    @objc func initAttributes(params: [String: Any]) -> URLQRCodeViewController {
        
        return self
    }
    
}
