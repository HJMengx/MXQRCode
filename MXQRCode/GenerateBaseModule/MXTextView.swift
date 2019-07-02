//
//  MXTextView.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/7/1.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit

class MXTextView: UITextView {

    init() {
        super.init(frame: CGRect.init(), textContainer: nil)
        self.initWithAccessoryView()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: CGRect.init(), textContainer: nil)
        self.initWithAccessoryView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initWithAccessoryView() {
        let toolBar = UIToolbar.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolBar.tintColor = UIColor.black
        toolBar.barTintColor = UIColor.lightGray
        let doneButton = UIBarButtonItem.init(title: "Close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(MXTextField.resign))
        let space = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.items = [space, doneButton]
        self.inputAccessoryView = toolBar
    }
    
    // Click the Done
    @objc func resign() {
        self.resignFirstResponder()
    }
}
