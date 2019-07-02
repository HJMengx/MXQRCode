//
//  ModifyQRCodeViewController.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/7/1.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

let ModifyQRCodeViewModifyDone = "ModifyQRCodeViewModifyDone"

enum ModifyQRCodeType: Int {
    case color = 0
    case text = 1
    case logo = 2
    case maskImg = 3
}

class ModifyQRCodeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var content: String!
    
    weak var qrImageView : UIImageView!
    
    var modifyImg : UIImage!
    
    var type : ModifyQRCodeType!
    
    // 文字
    weak var textView : MXTextView!
    
    weak var textColorItem : ToolItem!
    
    // 颜色
    weak var foreColor : UIButton!
    
    weak var backgroundColor : UIButton!
    
    weak var textColorWheelView : EFColorWheelView!
    
    // 图片-> Logo, 底图
    weak var removeImgButton : UIButton!
    
    weak var selectedFromPhotosButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(ModifyQRCodeViewController.removeTheColorWheelView)))
        
        self.initSubviews()
    }
    
    @objc func removeTheColorWheelView() {
        if self.textColorWheelView != nil {
//            self.textColorWheelView.removeFromSuperview()
        }
    }
    
    private func addRightBtn() {
        // rightSubmit
        let submitButton = UIButton.init(frame: CGRect.init(x: 0, y: 2, width: 24, height: 24))
        submitButton.setImage(UIImage.init(named: "确定"), for: UIControl.State.normal)
        submitButton.addTarget(self, action: #selector(ModifyQRCodeViewController.submitModify), for: UIControl.Event.touchUpInside)
        let container = UIView.init(frame: submitButton.bounds)
        container.addSubview(submitButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: container)
    }
    
    private func initSubviews() {
        if self.qrImageView == nil {
            self.view.backgroundColor = SceneColor
            // qrImage
            let image = UIImageView()
            self.qrImageView = image
            self.view.addSubview(self.qrImageView)
            self.qrImageView.layer.masksToBounds = true
            self.qrImageView.layer.cornerRadius = 5
            self.qrImageView.snp.makeConstraints { (make: ConstraintMaker) in
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.top.equalToSuperview().offset(TopHeight + 5)
                make.height.equalTo(self.view.bounds.width - 40)
            }
            
            if self.type == ModifyQRCodeType.color {
                self.title = "颜色"
                // 前景
                let foreButton = UIButton.init()
                self.foreColor = foreButton
                self.foreColor.addTarget(self, action: #selector(ModifyQRCodeViewController.selectedForeColor), for: UIControl.Event.touchUpInside)
                self.foreColor.layer.masksToBounds = true
                self.foreColor.layer.cornerRadius = 2
                self.foreColor.backgroundColor = UIColor.white
                self.view.addSubview(self.foreColor)
                self.foreColor.snp.makeConstraints { (make: ConstraintMaker) in
                    make.right.equalToSuperview().offset(-20)
                    make.width.equalTo(30)
                    make.height.equalTo(30)
                    make.top.equalTo(self.qrImageView.snp.bottom).offset(15)
                }
                // 中间区域
                let foreview = UIView.init()
                foreview.backgroundColor = UIColor.gray
                foreview.layer.masksToBounds = true
                foreview.layer.cornerRadius = 2
                self.foreColor.addSubview(foreview)
                foreview.snp.makeConstraints { (make: ConstraintMaker) in
                    make.center.equalToSuperview()
                    make.width.equalTo(20)
                    make.height.equalTo(20)
                }
                // 前景文案
                let foreLabel = UILabel.init()
                foreLabel.text = "前景色"
                foreLabel.textAlignment = .center
                foreLabel.textColor = UIColor.gray
                foreLabel.font = UIFont.systemFont(ofSize: 13)
                self.view.addSubview(foreLabel)
                foreLabel.snp.makeConstraints { (make: ConstraintMaker) in
                    make.width.equalTo(60)
                    make.height.equalTo(30)
                    make.centerX.equalTo(self.foreColor.snp.centerX)
                    make.top.equalTo(self.foreColor.snp.bottom).offset(5)
                }
                
                // 背景
                let backButton = UIButton.init()
                self.backgroundColor = backButton
                self.backgroundColor.addTarget(self, action: #selector(ModifyQRCodeViewController.selectedBackgroundColor), for: UIControl.Event.touchUpInside)
                self.backgroundColor.layer.masksToBounds = true
                self.backgroundColor.layer.cornerRadius = 2
                self.backgroundColor.backgroundColor = UIColor.gray
                self.view.addSubview(self.backgroundColor)
                self.backgroundColor.snp.makeConstraints { (make: ConstraintMaker) in
                    make.left.equalToSuperview().offset(20)
                    make.width.equalTo(30)
                    make.height.equalTo(30)
                    make.top.equalTo(self.qrImageView.snp.bottom).offset(15)
                }
                // 中间区域
                let backview = UIView.init()
                backview.backgroundColor = UIColor.white
                backview.layer.masksToBounds = true
                backview.layer.cornerRadius = 2
                self.foreColor.addSubview(backview)
                backview.snp.makeConstraints { (make: ConstraintMaker) in
                    make.center.equalToSuperview()
                    make.width.equalTo(20)
                    make.height.equalTo(20)
                }
                // 前景文案
                let backLabel = UILabel.init()
                backLabel.text = "背景色"
                backLabel.textAlignment = .center
                backLabel.textColor = UIColor.gray
                backLabel.font = UIFont.systemFont(ofSize: 13)
                self.view.addSubview(backLabel)
                backLabel.snp.makeConstraints { (make: ConstraintMaker) in
                    make.centerX.equalTo(self.backgroundColor.snp.centerX)
                    make.width.equalTo(60)
                    make.height.equalTo(30)
                    make.top.equalTo(self.backgroundColor.snp.bottom).offset(5)
                }
            } else if self.type == ModifyQRCodeType.text {
                self.title = "文字"
                // 文案
                let textView = MXTextView.init()
                self.textView = textView
                self.textView.textColor = UIColor.black
                self.textView.delegate = self
                self.textView.layer.borderWidth = 0.5
                self.textView.layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
                self.view.addSubview(self.textView)
                self.textView.snp.makeConstraints { (make: ConstraintMaker) in
                    make.left.equalToSuperview().offset(20)
                    make.right.equalToSuperview().offset(-20)
                    make.top.equalTo(self.qrImageView.snp.bottom).offset(15)
                    make.height.equalTo(80)
                }
                // 颜色按钮
                let toolItem = ToolItem.init()
                self.textColorItem = toolItem
                toolItem.itemIcon.backgroundColor = UIColor.clear
                toolItem.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(ModifyQRCodeViewController.selectedTextColor)))
                self.view.addSubview(toolItem)
                toolItem.snp.makeConstraints { (make: ConstraintMaker) in
                    make.centerX.equalToSuperview()
                    make.width.equalTo(ToolItemWidth)
                    make.top.equalTo(self.textView.snp.bottom).offset(10)
                    make.height.equalTo(ToolItemHeight)
                }
                toolItem.settingAttributes(imageName: "颜色", itemText: "文本颜色")
                
            } else if self.type == ModifyQRCodeType.logo || self.type == ModifyQRCodeType.maskImg {
                self.title = "Logo"
                // 去除效果
                let removeItem = ToolItem.init()
                removeItem.itemIcon.backgroundColor = UIColor.clear
                removeItem.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(ModifyQRCodeViewController.removeImages)))
                self.view.addSubview(removeItem)
                removeItem.snp.makeConstraints { (make: ConstraintMaker) in
                    make.centerX.equalToSuperview().offset(-ToolItemWidth)
                    make.width.equalTo(ToolItemWidth)
                    make.top.equalTo(self.qrImageView.snp.bottom).offset(10)
                    make.height.equalTo(ToolItemHeight)
                }
                removeItem.settingAttributes(imageName: "去除", itemText: "去除效果")
                // 打开相册
                let openItem = ToolItem.init()
                openItem.itemIcon.backgroundColor = UIColor.clear
                openItem.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(ModifyQRCodeViewController.selectedImages)))
                self.view.addSubview(openItem)
                openItem.snp.makeConstraints { (make: ConstraintMaker) in
                    make.centerX.equalToSuperview().offset(ToolItemWidth)
                    make.width.equalTo(ToolItemWidth)
                    make.top.equalTo(self.qrImageView.snp.bottom).offset(10)
                    make.height.equalTo(ToolItemHeight)
                }
                openItem.settingAttributes(imageName: "底图", itemText: "打开相册")
            }
            
            self.addRightBtn()
        }
    }
    
    private func initBottomActions() {
        let container = UIView.init()
        self.view.addSubview(container)
        container.backgroundColor = UIColor.white
        container.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            if hasBang {
                make.height.equalTo(40 + ToolItemHeight + 5)
            } else {
                make.height.equalTo(ToolItemHeight + 5)
            }
        }
        
        // left dismiss
        let dismissButton = UIButton.init()
        container.addSubview(dismissButton)
        dismissButton.setTitle("X", for: UIControl.State.normal)
        dismissButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        dismissButton.addTarget(self, action: #selector(ModifyQRCodeViewController.dismissModify), for: UIControl.Event.touchUpInside)
        dismissButton.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(3)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        // rightSubmit
        let submitButton = UIButton.init()
        container.addSubview(submitButton)
        submitButton.setTitle("✔️", for: UIControl.State.normal)
        submitButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        submitButton.addTarget(self, action: #selector(ModifyQRCodeViewController.submitModify), for: UIControl.Event.touchUpInside)
        submitButton.snp.makeConstraints { (make: ConstraintMaker) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(3)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
    }
    
    // MARK: Actions
    @objc func removeImages() {
        // back to init
        self.qrImageView.image = self.modifyImg
    }
    
    @objc func selectedImages() {
        self.openPhotoAlbum()
    }

    @objc func selectedTextColor() {
        if self.textColorWheelView == nil {
            let colorSelectView = EFColorWheelView.init()
            self.textColorWheelView = colorSelectView
            colorSelectView.addTarget(self, action: #selector(ModifyQRCodeViewController.textColorChanged(colorView:)), for: UIControl.Event.valueChanged)
            self.view.addSubview(colorSelectView)
            colorSelectView.snp.makeConstraints { (make: ConstraintMaker) in
                make.centerX.equalTo(self.textColorItem.snp.centerX)
                make.width.equalTo(150)
                make.top.equalTo(self.textColorItem.snp.bottom).offset(10)
                make.height.equalTo(150)
            }
        } else {
            self.textColorWheelView.removeFromSuperview()
        }
    }
    
    @objc func textColorChanged(colorView: EFColorWheelView) {
        self.textView.textColor = UIColor.init(hue: colorView.hue, saturation: colorView.saturation, brightness: colorView.brightness, alpha: 1.0)
        // 切换
        
    }
    
    @objc func tetContentChange() {
        if self.textView.text.count > 0 {
            MXManager.sharedInstance.generateQRCodeWithText(parameters: ["content": self.content!, "dotColor": CIColor.init(color: UIColor.black), "backgroundColor": CIColor.init(color: UIColor.white),"textColor": self.textView.textColor!, "text": self.textView.text!]) { (img: UIImage?) in
                if img == nil {
                    SVProgressHUD.showError(withStatus: "出现错误, 请重试")
                } else {
                    self.qrImageView.image = img
                }
            }
        } else {
            self.qrImageView.image = self.modifyImg
        }
    }
    
    @objc func selectedForeColor() {
        
    }
    
    @objc func selectedBackgroundColor() {
        
    }
    
    @objc func dismissModify() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func submitModify() {
        // Notify
        let noti = Notification.init(name: NSNotification.Name.init(rawValue: ModifyQRCodeViewModifyDone), object: self.qrImageView.image!)
        NotificationCenter.default.post(noti)
        // pop
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func initAttributes(params: [String: Any]) -> ModifyQRCodeViewController {
        
        self.extractParams(params: params)
        
        self.initSubviews()

        self.qrImageView.image = self.modifyImg
        
        return self
    }
    
    // MARK: Params analysis
    private func extractParams(params: [String: Any]) {
        self.content = params["content"] as? String
        self.modifyImg = params["qrImage"] as? UIImage
        self.type = params["type"] as? ModifyQRCodeType
 //        if params.contains(where: { (arg0) -> Bool in
//
//            let (key, value) = arg0
//            if key == "dotColor" && (value as? CIColor) != nil {
//                return true
//            }
//            return false
//        }) {
//            self.dotColor = params["dotColor"] as? CIColor
//        }
        
    }
    
    // MARK: Photos
    func openPhotoAlbum()
    {
        LBXPermissions.authorizePhotoWith { [weak self] (granted) in
            
            let picker = UIImagePickerController()
            
            // UIImagePickerController.sourceType.photoLibrary
            picker.sourceType = .photoLibrary
            
            picker.delegate = self
            
            self?.present(picker, animated: true, completion: nil)
        }
    }
    
    //MARK: -----相册选择图片识别二维码 （条形码没有找到系统方法）
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        picker.dismiss(animated: true, completion: nil)
        // info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey)] as! UIImage
        var image:UIImage? = info[.editedImage] as? UIImage
        
        if (image == nil )
        {
            //info[.originalImage] as! UIImage info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
            image = info[.originalImage] as? UIImage
        }
        
        if(image != nil)
        {
            if self.type == ModifyQRCodeType.logo {
                // Get Logo Image
                MXManager.sharedInstance.generateQRCode(parameters: ["content": self.content!, "dotColor": CIColor.init(color: UIColor.white), "backgroundColor": CIColor.init(color: UIColor.black), "iconImage": image!]) { (img: UIImage?) in
                    if img != nil {
                        self.qrImageView.image = img!
//                        self.modifyImg = img!
                    } else {
                        SVProgressHUD.showError(withStatus: "生成失败, 请重试")
                    }
                }
            } else if self.type == ModifyQRCodeType.maskImg {
                // Get Mask Image
                MXManager.sharedInstance.generateQRCodeWithMaskImg(parameters: ["content": self.content!, "dotColor": CIColor.init(color: UIColor.black), "backgroundColor": CIColor.init(color: UIColor.clear), "maskImg": image!]) { (img: UIImage?) in
                    if img != nil {
                        self.qrImageView.image = img!
                        // 修改不改变
//                        self.modifyImg = img!
                    } else {
                        SVProgressHUD.showError(withStatus: "生成失败, 请重试")
                    }
                }
            }
        }
    }
}


extension ModifyQRCodeViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.tetContentChange()
    }
}
