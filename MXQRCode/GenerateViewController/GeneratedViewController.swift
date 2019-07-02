//
//  GeneratedViewController.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/30.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

private let qrImgWidth: CGFloat = UIScreen.main.bounds.width - 40
private let qrImgPosition = CGPoint.init(x: 20, y: TopHeight + 20)

class GeneratedViewController: UIViewController {
    // extract the qrcode content
    var content : String!
    
    var dotColor : CIColor?
    
    var backgroundColor : CIColor?
    
    weak var qrImgView: UIImageView!
    
    weak var barImgView: UIImageView!
    
    var iconImg : UIImage? = UIImage.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "二维码"
        
        self.view.backgroundColor = SceneColor
        
        self.initSubviews()
    }
    
    @objc func modifyDone(noti: Notification) {
        guard let modifyImg = noti.object as? UIImage else {
            return
        }
        self.qrImgView.image = modifyImg
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GeneratedViewController.modifyDone(noti:)), name: NSNotification.Name.init(rawValue: ModifyQRCodeViewModifyDone), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    private func initSubviews() {
        if self.qrImgView == nil {
            // QRView
            let qrView = UIImageView.init()
            self.qrImgView = qrView
            self.qrImgView.layer.cornerRadius = 5
            self.qrImgView.layer.masksToBounds = true
            self.view.addSubview(qrImgView)
            self.qrImgView.snp.makeConstraints { (make: ConstraintMaker) in
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.top.equalToSuperview().offset(TopHeight + 20)
                make.height.equalTo(self.view.bounds.width - 40)
            }
            // BarView
            let barView = UIImageView.init()
            self.barImgView = barView
            self.barImgView.layer.cornerRadius = 5
            self.barImgView.layer.masksToBounds = true
            self.view.addSubview(barImgView)
            self.barImgView.snp.makeConstraints { (make: ConstraintMaker) in
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.top.equalTo(self.qrImgView.snp.bottom).offset(30)
                make.height.equalTo(80)
            }
            // BottomIcons
            self.initBottomActions()
        }
    }
    
    private func initBottomActions(){
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
        // buttons
        let imgs = ["颜色", "文字1", "logo", "底图"]
        let names = ["颜色", "文字", "Logo", "底图"]
        
        let y : CGFloat = 2
        let gap = (self.view.bounds.width - 4 * ToolItemWidth) / CGFloat(imgs.count + 1)
        
        for index in 0..<4 {
            let x = CGFloat(index + 1) * gap + CGFloat(index) * ToolItemWidth
            let toolItem = ToolItem.init(frame: CGRect.init(x: x, y: y, width: ToolItemWidth, height: ToolItemHeight))
            toolItem.settingAttributes(imageName: imgs[index], itemText: names[index])
            toolItem.backgroundColor = UIColor.white
            toolItem.itemIcon.backgroundColor = UIColor.clear
            toolItem.tag = index
            toolItem.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(GeneratedViewController.executeAction(gesture:))))
            container.addSubview(toolItem)
        }
    }
    
    @objc func executeAction(gesture: UITapGestureRecognizer) {
        
        let sender = gesture.view!
        
        switch sender.tag {
        case 0:
            // Color
            MXManager.sharedInstance.createModifyQRCodeVC(parameters: ["content": self.content!, "qrImage": self.qrImgView.image!, "type": ModifyQRCodeType.color]) { (modifyQRVC: ModifyQRCodeViewController?) in
                if modifyQRVC == nil {
                    SVProgressHUD.showError(withStatus: "出现错误, 请重试")
                } else {
                    self.navigationController?.pushViewController(modifyQRVC!, animated: true)
                }
            }
            break
        case 1:
            // Text
            MXManager.sharedInstance.createModifyQRCodeVC(parameters: ["content": self.content!, "qrImage": self.qrImgView.image!, "type": ModifyQRCodeType.text]) { (modifyQRVC: ModifyQRCodeViewController?) in
                if modifyQRVC == nil {
                    SVProgressHUD.showError(withStatus: "出现错误, 请重试")
                } else {
                    self.navigationController?.pushViewController(modifyQRVC!, animated: true)
                }
            }
            break
        case 2:
            // Logo
            MXManager.sharedInstance.createModifyQRCodeVC(parameters: ["content": self.content!, "qrImage": self.qrImgView.image!, "type": ModifyQRCodeType.logo]) { (modifyQRVC: ModifyQRCodeViewController?) in
                if modifyQRVC == nil {
                    SVProgressHUD.showError(withStatus: "出现错误, 请重试")
                } else {
                    self.navigationController?.pushViewController(modifyQRVC!, animated: true)
                }
            }
            break
        case 3:
            // 底图
            MXManager.sharedInstance.createModifyQRCodeVC(parameters: ["content": self.content!, "qrImage": self.qrImgView.image!, "type": ModifyQRCodeType.maskImg]) { (modifyQRVC: ModifyQRCodeViewController?) in
                if modifyQRVC == nil {
                    SVProgressHUD.showError(withStatus: "出现错误, 请重试")
                } else {
                    self.navigationController?.pushViewController(modifyQRVC!, animated: true)
                }
            }
            break
        default:
            
            break
        }
    }
    
    // MARK: Action With Module
    @objc func getQRCode(params: [String : Any]) -> UIImage? {
        
        self.extractParams(params: params)
        
        return self.createQRForString(qrString: self.content, qrIconImage: self.iconImg, backgroundColor: self.backgroundColor, dotColor: self.dotColor)
    }

    @objc func getBarCode(params: [String : Any]) -> UIImage? {
        self.extractParams(params: params)
        
        return self.createBarCode(messgae: self.content as NSString, width: self.view.bounds.width - 40, height: 80)
    }
    
    @objc func getQRCodeAddText(params: [String: Any]) -> UIImage? {
        self.extractParams(params: params)
        
        guard let qrImg = self.createQRForString(qrString: self.content, qrIconImage: self.iconImg, backgroundColor: self.backgroundColor, dotColor: self.dotColor) else {
            return nil
        }
        // 必须包含
        return self.createQRCodeWithText(text: params["text"] as! String, qrImage: qrImg, textColor: params["textColor"] as? UIColor)
    }
    
    @objc func getQRCodeAddMaskImg(params: [String: Any]) -> UIImage? {
        self.extractParams(params: params)
        
        guard let qrImg = self.createQRForString(qrString: self.content, qrIconImage: self.iconImg, backgroundColor: self.backgroundColor, dotColor: self.dotColor) else {
            return nil
        }
        
        return self.createQRCodeWithMaskImage(qrImage: qrImg, maskImage: params["maskImg"] as! UIImage)
    }
    
    // MARK: Init With Module
    @objc func initAttributes(params: [String: Any]) -> GeneratedViewController {
        
        self.initSubviews()
        
        self.extractParams(params: params)
        
        self.qrImgView.image = self.createQRForString(qrString: self.content, qrIconImage: self.iconImg, backgroundColor: self.backgroundColor, dotColor: self.dotColor)
        // self.view.bounds.width - 40
        self.barImgView.image = self.createBarCode(messgae: self.content as NSString, width: qrImgWidth, height: 80)
        
        return self
    }
    
    // MARK: Params analysis
    private func extractParams(params: [String: Any]) {
        self.content = params["content"] as? String
        if params.contains(where: { (arg0) -> Bool in
            
            let (key, value) = arg0
            if key == "dotColor" && (value as? CIColor) != nil {
                return true
            }
            return false
        }) {
            self.dotColor = params["dotColor"] as? CIColor
        }
        
        if params.contains(where: { (arg0) -> Bool in
            
            let (key, value) = arg0
            
            if key == "backgroundColor" && (value as? CIColor) != nil{
                return true
            }
            return false
        }) {
            self.backgroundColor = params["backgroundColor"] as? CIColor
        }
        
        if params.contains(where: { (arg0) -> Bool in
            
            let (key, value) = arg0
            
            if key == "iconImage" && (value as? UIImage) != nil{
                return true
            }
            return false
        }) {
            self.iconImg = params["iconImage"] as? UIImage
        }
    }
}

extension GeneratedViewController {
    func createQRForString(qrString: String?, qrIconImage: UIImage?, backgroundColor: CIColor? = CIColor(red: 1, green: 1, blue: 1), dotColor: CIColor? = CIColor(red: 0, green: 0, blue: 0)) -> UIImage?{
        if let sureQRString = qrString{
            let stringData = sureQRString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //创建一个二维码的滤镜
            let qrFilter = CIFilter(name: "CIQRCodeGenerator")
            qrFilter?.setValue(stringData, forKey: "inputMessage")
            qrFilter?.setValue("H", forKey: "inputCorrectionLevel")
            let qrCIImage = qrFilter?.outputImage
            // 创建一个颜色滤镜, 外界输入颜色
            let colorFilter = CIFilter(name: "CIFalseColor")!
            colorFilter.setDefaults()
            colorFilter.setValue(qrCIImage, forKey: "inputImage")
            colorFilter.setValue(dotColor, forKey: "inputColor0")
            colorFilter.setValue(backgroundColor, forKey: "inputColor1")
            // 返回二维码imagE
            let codeImage = UIImage.init(ciImage: colorFilter.outputImage!.transformed(by: CGAffineTransform(scaleX: 20, y: 20)))
//                self.improveTheQuality(ciImage: colorFilter.outputImage!.transformed(by: CGAffineTransform(scaleX: 5, y: 5)))
            // 中间一般放logo
            if let iconImage = qrIconImage {
                let resultImage = self.getClearImage(sourceImage: codeImage, center: iconImage)
                
                return resultImage
            }
            return codeImage
        }
        return nil
    }
    
    // improve the qrcode quality
    func getClearImage(sourceImage: UIImage, center: UIImage) -> UIImage {
        // sourceImage.size
        let size = CGSize.init(width: qrImgWidth, height: qrImgWidth)
        // 开启图形上下文
        UIGraphicsBeginImageContext(size)
        
        // 绘制大图片
        sourceImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // 绘制二维码中心小图片
        let width: CGFloat = 80
        let height: CGFloat = 80
        let x: CGFloat = (size.width - width) * 0.5
        let y: CGFloat = (size.height - height) * 0.5
        center.draw(in: CGRect(x: x, y: y, width: width, height: height))
        
        // 取出结果图片
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭上下文
        UIGraphicsEndImageContext()
        
        return resultImage!
    }
    
    // 生成带底图的
    func createQRCodeWithMaskImage(qrImage: UIImage, maskImage: UIImage) -> UIImage {
        // qrImage.size
        let size = CGSize.init(width: qrImgWidth, height: qrImgWidth)
        // 开启图形上下文
        UIGraphicsBeginImageContext(size)
        
        // 绘制大图片
        maskImage.draw(in: CGRect(x: 10, y: 10, width: size.width - 20, height: size.height - 20))
        
        // 绘制二维码
        qrImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // 取出结果图片
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭上下文
        UIGraphicsEndImageContext()
        
        return resultImage!
    }
    
    // 生成带文字内容的
    func createQRCodeWithText(text: String, qrImage: UIImage, textColor: UIColor? = UIColor.black) -> UIImage {
        let labelSize = CGSize.init(width: qrImgWidth, height: 50)
        
        let containerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: qrImgWidth, height: qrImgWidth + labelSize.height))
        
        // qrcode
        let tempQRImgView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: qrImgWidth, height: qrImgWidth))
        
        tempQRImgView.image = qrImage
        
        containerView.addSubview(tempQRImgView)
        
        // addText
        let textLabel = UILabel.init(frame: CGRect.init(x: 0, y: qrImgWidth, width: qrImgWidth, height: 50))
        
        textLabel.textAlignment = .center
        
        textLabel.textColor = textColor
        
        textLabel.backgroundColor = UIColor.init(ciColor: self.backgroundColor!)
        
        textLabel.font = UIFont.systemFont(ofSize: 14)
        
        textLabel.numberOfLines = 0
        
        textLabel.text = text
        
        containerView.addSubview(textLabel)
        
        // Get the Image
        
        UIGraphicsBeginImageContextWithOptions(containerView.bounds.size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else { return qrImage }
        
        containerView.layer.render(in: context)
        
        guard let resultImg = UIGraphicsGetImageFromCurrentImageContext() else {
            return qrImage
        }
        
        UIGraphicsEndImageContext()
        
        return resultImg
    }
    
    //生成条形码
    func createBarCode(messgae:NSString,width:CGFloat,height:CGFloat) -> UIImage {
        var returnImage:UIImage?
        if (messgae.length > 0 && width > 0 && height > 0){
            let inputData:NSData? = messgae.data(using: String.Encoding.utf8.rawValue)! as NSData
            // CICode128BarcodeGenerator
            let filter = CIFilter.init(name: "CICode128BarcodeGenerator")!
            filter.setValue(inputData, forKey: "inputMessage")
            guard let ciImage = filter.outputImage else {
                return UIImage.init()
            }
            let scaleX = width/ciImage.extent.size.width
            let scaleY = height/ciImage.extent.size.height
            let transformCIImage = ciImage.transformed(by: CGAffineTransform.init(scaleX: scaleX, y: scaleY))
            returnImage = UIImage.init(ciImage: transformCIImage)
        }else {
            returnImage = UIImage.init()
        }
        return returnImage!
    }
}
