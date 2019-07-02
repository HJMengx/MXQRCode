//
//  CardQRCodeViewController.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/29.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import SnapKit

private let names = ["姓名", "电话", "公司", "职位", "Email"]

private let placeholders = ["请输入姓名", "请输入电话", "请输入公司", "请输入职位", "请输入邮箱"]

class CardQRCodeViewController: GenerateBaseViewController {

    weak var cardTableView : UITableView!
    
    weak var generateButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "名片"
        self.initSubviews()
    }
    
    private func initSubviews() {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: Int(TopHeight), width: Int(self.view.bounds.width), height: CardQRCodeCellHeight * 5 + 10), style: UITableView.Style.plain)
        self.cardTableView = tableView
        self.cardTableView.delegate = self
        self.cardTableView.dataSource = self
        self.view.addSubview(self.cardTableView)
        // Generate Button
        let generateBtn = UIButton.init()
        self.generateButton = generateBtn
        self.view.addSubview(self.generateButton)
        self.generateButton.addTarget(self, action: #selector(CardQRCodeViewController.geenrateQRCode), for: UIControl.Event.touchUpInside)
        self.generateButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.generateButton.backgroundColor = MainColor
        self.generateButton.titleLabel?.textAlignment = .center
        self.generateButton.layer.cornerRadius = 5
        self.generateButton.layer.masksToBounds = true
        self.generateButton.setTitle("生成二维码", for: UIControl.State.normal)
        self.generateButton.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(self.cardTableView.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
    }
    
    @objc func geenrateQRCode() {
        //  Navigate to generate Page if success
        
    }
    
    @objc func initAttributes(params: [String: Any]) -> CardQRCodeViewController {
        
        return self
    }

    
}

extension CardQRCodeViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : CardQRCodeCell? = tableView.dequeueReusableCell(withIdentifier: CardQRCodeCellIdentifier) as? CardQRCodeCell
        
        if cell == nil {
            cell = CardQRCodeCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: CardQRCodeCellIdentifier)
        }
        
        cell?.settingAttributes(title: names[indexPath.row], placeHolder: placeholders[indexPath.row])
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // do not anythign
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(CardQRCodeCellHeight)
    }
}
