//
//  HistoryView.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/27.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import SnapKit

enum HistoryViewClickType {
    case generate
    case scan
}

typealias HistoryClicked = (_ type: HistoryViewClickType)->Void

class HistoryView: UIView {
    
    weak var historyIcon : HistoryCell!
    
    weak var scanHistory : HistoryCell!
    
    weak var generateHisotry: HistoryCell!
    
    var clicked : HistoryClicked!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func initSubviews() {
        let hisIcon = HistoryCell.init(isIcon: true)
        self.historyIcon = hisIcon
        self.addSubview(self.historyIcon)
        self.historyIcon.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(100)
        }
        self.historyIcon.settingAtrribute(title: "历史记录", other: "历史")
        //
        let splitView = UIView.init()
        splitView.backgroundColor = UIColor.gray
        self.addSubview(splitView)
        splitView.alpha = 0.5
        splitView.snp.makeConstraints { (make: ConstraintMaker) in
            make.width.equalTo(1)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalTo(self.snp.left).offset(95)
        }
        // 获取间隔
        let gap = (UIScreen.main.bounds.width - 240 - 95) / 3.0
        // Scan His
        let scanLbel = HistoryCell.init(isIcon: false)
        self.scanHistory = scanLbel
        self.addSubview(self.scanHistory)
        self.scanHistory.snp.makeConstraints { (make: ConstraintMaker) in
            make.right.equalToSuperview().offset(-gap)
            make.width.equalTo(100)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        self.scanHistory.settingAtrribute(title: "扫描历史", other: "0")
        
        self.scanHistory.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(HistoryView.itemBeClicked(gesture:))))
        // Generate His
        let genLabel = HistoryCell.init(isIcon: false)
        self.generateHisotry = genLabel
        self.addSubview(self.generateHisotry)
        self.generateHisotry.snp.makeConstraints { (make: ConstraintMaker) in
            make.right.equalTo(self.scanHistory.snp.left).offset(-gap)
            make.width.equalTo(100)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        self.generateHisotry.settingAtrribute(title: "生成历史", other: "0")
        self.generateHisotry.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(HistoryView.itemBeClicked(gesture:))))
    }
    
    @objc func itemBeClicked(gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else {
            return
        }
        
        if self.clicked == nil {
            return
        }
        
        if view == self.generateHisotry {
            self.clicked(.generate)
        } else if view == self.scanHistory {
            self.clicked(.scan)
        }
    }
}
