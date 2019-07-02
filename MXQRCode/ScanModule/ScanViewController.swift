//
//  ScanViewController.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/26.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import SnapKit

class ScanViewController: LBXScanViewController {

    var photosImageView : UIButton!
    
    var origin : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "扫描二维码"
        
        // Do any additional setup after loading the view.
    }
    
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        if arrayResult.count > 0 {
            let content = arrayResult.first!.strScanned!
            let codeType = arrayResult.first!.strBarCodeType!
            print("content: \(String(describing: content)), codeType: \(codeType)")
        }
        print(arrayResult)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 初始化
        self.initSubviews()
    }
    
    private func initSubviews() {
        let button = UIButton.init()
        self.photosImageView = button
        self.photosImageView.backgroundColor = UIColor(red: 0.0, green: 167.0/255.0, blue: 231.0/255.0, alpha: 1.0)
            // UIColor.init(red: 90 / 255.0, green: 186 / 255.0, blue: 156 / 255.0, alpha: 1.0)
        self.photosImageView.setImage(UIImage.init(named: "相册"), for: UIControl.State.normal)
        self.photosImageView.addTarget(self, action: #selector(ScanViewController.gotoPhotos), for: UIControl.Event.touchUpInside)
        self.view.addSubview(self.photosImageView)
        self.photosImageView.snp.makeConstraints { (make: ConstraintMaker) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        self.photosImageView.layer.masksToBounds = true
        self.photosImageView.layer.cornerRadius = 30
        // 文字
        let photoLabel = UILabel.init()
        photoLabel.textColor = UIColor.white
        photoLabel.textAlignment = .center
        photoLabel.text = "相册"
        self.view.addSubview(photoLabel)
        photoLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.equalTo(self.photosImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
    }
    
    @objc func InitScanVC(params: [String: Any]) -> ScanViewController {
        
        self.origin = params["origin"] as? String
        
        return self
    }
    
    @objc func gotoPhotos() {
        self.openPhotoAlbum()
    }
}
