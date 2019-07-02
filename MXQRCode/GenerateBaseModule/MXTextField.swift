//
//  MXTextField.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/29.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit

class MXTextField: UITextField {
    
    var maxLength : Int = 0
    
    init() {
        super.init(frame: CGRect())
        self.initWithAccessoryView()
        // 增加内容监听
        self.addTarget(self, action: #selector(MXTextField.textDidChanged(textField:)), for: UIControl.Event.valueChanged)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    
    @objc func textDidChanged(textField: MXTextField) {
        if self.maxLength == 0 {
            return
        }
        //
        guard let currentText = textField.text else {
            return
        }
        let lang = textField.textInputMode?.primaryLanguage
        if lang != nil {
            if lang! == "zh-Hans" {
                // highlight for chinense
                guard let range = textField.markedTextRange else {
                    if currentText.count > self.maxLength {
                        //                let maxIndex = currentText.index(currentText.startIndex, offsetBy: self.maxLength)
                        textField.text = String(currentText.prefix(self.maxLength))
                    }
                    return
                }
                guard let _ = textField.position(from: range.start, offset: 0) else {
                    if currentText.count > self.maxLength {
                        //                let maxIndex = currentText.index(currentText.startIndex, offsetBy: self.maxLength)
                        textField.text = String(currentText.prefix(self.maxLength))
                    }
                    return
                }
                // contain chinese
                if currentText.lengthOfBytes(using: String.Encoding.utf8) > self.maxLength {
                    textField.text = String(currentText.prefix(self.maxLength))
                }
            } else {
                if currentText.count > self.maxLength {
                    //                let maxIndex = currentText.index(currentText.startIndex, offsetBy: self.maxLength)
                    textField.text = String(currentText.prefix(self.maxLength))
                }
            }
        } else {
            // compare the width
            if currentText.count > self.maxLength {
//                let maxIndex = currentText.index(currentText.startIndex, offsetBy: self.maxLength)
                textField.text = String(currentText.prefix(self.maxLength))
            }
        }
    }
    
    
    // MARK: 内容修改通知部分
//    - (void) registerNotification {
//    // 内容改变的时候调用
//    [self addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
//    }
//
//    - (void) textDidChanged:(UITextField*) textField {
//    if (self.maxLength == 0) {
//    return;
//    }
//    NSString *toBeString = textField.text;
//    NSString *lang = [[textField textInputMode] primaryLanguage]; // 键盘输入模式
//    if ([lang isEqualToString:@"zh-Hans"]) {                      // 简体中文输入，包括简体拼音，健体五笔，简体手写
//    //判断markedTextRange是不是为Nil，如果为Nil的话就说明你现在没有未选中的字符，
//    //可以计算文字长度。否则此时计算出来的字符长度可能不正确
//    UITextRange *selectedRange = [textField markedTextRange];
//    //获取高亮部分(输入中文的时候才有)
//    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
//    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
//    if (!position) {
//    //中文和字符一起检测  中文是两个字符
//    if ([toBeString getStringLenthOfBytes] > self.maxLength) {
//    textField.text = [toBeString subBytesOfstringToIndex:self.maxLength];
//    }
//    }
//    } else {
//    if ([toBeString getStringLenthOfBytes] > self.maxLength) {
//    textField.text = [toBeString subBytesOfstringToIndex:self.maxLength];
//    }
//    }
//    }
}
