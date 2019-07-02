//
//  ImageQRCodeViewController.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/30.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

private let imgs = ["相机", "加"]

class ImageQRCodeViewController: GenerateBaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    weak var selectedImgButton : UIButton!
    
    weak var showImgView : UIImageView!
    
    weak var generateButton : UIButton!
    
    var selectedImg : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "图片"
        self.initSubviews()
        // Do any additional setup after loading the view.
    }
    
    private func initSubviews() {
        let imgView = UIImageView.init()
        self.showImgView = imgView
        self.view.addSubview(self.showImgView)
        self.showImgView.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(TopHeight + 5)
            make.height.equalTo(0)
        }
        
        // Contaniner
        let container = self.initButtons()
        
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
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(container.snp.bottom).offset(5)
            make.height.equalTo(40)
        }
    }
    
    private func initButtons() -> UIView {
        // Base params
        let numberOfRow = 4
        let numberOfWidth = 40
        let numberOfHeight = 40
        let colGap: CGFloat = 16
        let containerHeight = CGFloat(numberOfHeight) + colGap
        // container
        let containerView = UIView.init()
        self.view.addSubview(containerView)
        containerView.backgroundColor = self.view.backgroundColor
        containerView.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(self.showImgView.snp.bottom).offset(10)
            make.height.equalTo(containerHeight)
        }
        // Buttons
        for index in 0..<imgs.count {
            var x : CGFloat = self.view.center.x - CGFloat(numberOfWidth) -  CGFloat(numberOfWidth) / CGFloat(2.0)
            let y : CGFloat = 8
            
            let position = index % numberOfRow
            
            if position != 0 {
                x = self.view.center.x +  CGFloat(numberOfWidth) / CGFloat(2.0)
            }
        
            let itemBtn = UIButton.init(frame: CGRect.init(x: x, y: y, width: CGFloat(numberOfWidth), height: CGFloat(numberOfHeight)))
            itemBtn.tag = index
            itemBtn.backgroundColor = UIColor(red: 0.0, green: 167.0/255.0, blue: 231.0/255.0, alpha: 1.0)
            itemBtn.addTarget(self, action: #selector(ImageQRCodeViewController.btnClick(sender:)), for: UIControl.Event.touchUpInside)
            itemBtn.layer.cornerRadius = 5
            itemBtn.layer.masksToBounds = true
            itemBtn.setImage(UIImage.init(named: imgs[index]), for: UIControl.State.normal)
            
            containerView.addSubview(itemBtn)
        }
        containerView.backgroundColor = UIColor.white
        return containerView
    }
    
    @objc func btnClick(sender: UIButton) {
        if sender.tag == 0 {
            // Camera
            
        } else if sender.tag == 1 {
            // photo
            self.openPhotoAlbum()
        }
    }
    
    open func openPhotoAlbum()
    {
        LBXPermissions.authorizePhotoWith { [weak self] (granted) in
            
            let picker = UIImagePickerController()
            
            // UIImagePickerController.sourceType.photoLibrary
            picker.sourceType = .photoLibrary
            
            picker.delegate = self;
            
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
            self.selectedImg = image!
            // Show the selected Image
            self.showImgView.image = self.selectedImg
            self.showImgView.snp.remakeConstraints { (make: ConstraintMaker) in
                make.left.equalToSuperview().offset(40)
                make.right.equalToSuperview().offset(-40)
                make.top.equalToSuperview().offset(TopHeight + 10)
                make.height.equalTo(200)
            }
        }
    }
    
    @objc func geenrateQRCode() {
        // Upload
        guard let url = self.uplaodImg(img: self.selectedImg)  else {
            SVProgressHUD.showError(withStatus: "生成出现错误, 请重试")
            return
        }
        //  Navigate to generate Page if success
        self.gotoGeneratedPage(content: url)
    }
    
    private func uplaodImg(img: UIImage) -> String? {
        
        return nil
    }
    
    @objc func initAttributes(params: [String: Any]) -> ImageQRCodeViewController {
        
        return self
    }
}


