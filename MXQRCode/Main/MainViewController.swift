//
//  MainViewController.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/26.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD
import GoogleMobileAds

let SceneColor = UIColor.init(red: 237 / 255.0, green: 237 / 255.0, blue: 237 / 255.0, alpha: 237 / 255.0)

class MainViewController: UIViewController, GADBannerViewDelegate {
    
    weak var toolView : ToolCellView!
    
    weak var historyView : HistoryView!
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = SceneColor
        
        self.title = "二维码小助手"
        
        self.addScanButton()
        
        self.initSubviews()
    }
    
    // MARK: initialize view
    private func addScanButton() {
        let container = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 24, height: 24))
        let scanBtn = UIButton.init(frame: container.bounds)
        container.addSubview(scanBtn)
        
        scanBtn.setBackgroundImage(UIImage.init(named: "scan"), for: UIControl.State.normal)
        
        scanBtn.setBackgroundImage(UIImage.init(named: "scan"), for: UIControl.State.highlighted)
        
        scanBtn.addTarget(self, action: #selector(MainViewController.gotoScan), for: UIControl.Event.touchUpInside)
        
        let navScanItem = UIBarButtonItem.init(customView: container)
        
        self.navigationItem.rightBarButtonItem = navScanItem
    }
    
    private func initSubviews() {
        // Function
        let toolView = ToolCellView.init(frame: CGRect.init(x: 20, y: TopHeight + 30, width: self.view.bounds.width - 40, height: ToolCellViewHeight))
        self.view.addSubview(toolView)
        self.toolView = toolView
        self.toolView.layer.cornerRadius = 5
        self.toolView.layer.masksToBounds = true
        self.toolView.layer.shadowColor = UIColor.black.cgColor
        self.toolView.layer.shadowOpacity = 0.8
        // setting item; expectly.
        let names = ["文本", "名片", "网址", "图片", "批量"]
        let imageNames = ["文本", "名片", "网址", "图片1", "文件"]
        
        toolView.initSubivews(numberOfItems: names.count, names: names, imageNames: imageNames)
        
        self.toolView.clicked = {  (index) -> Void in
            print("Clicked in \(index)")
            switch index {
            case 0:
                MXManager.sharedInstance.createTextQRCodeVC(parameters: ["origin": "MainViewController"], completion: { (textVC : TextQRCodeViewController?) in
                    if textVC != nil {
                        self.navigationController?.pushViewController(textVC!, animated: true)
                    } else {
                        SVProgressHUD.showError(withStatus: "出现错误, 请重试")
                    }
                })
                break
            case 1:
                MXManager.sharedInstance.createCardQRCodeVC(parameters: ["origin": "MainViewController"], completion: { (CardVC: CardQRCodeViewController?) in
                    if CardVC != nil {
                        self.navigationController?.pushViewController(CardVC!, animated: true)
                    } else {
                        SVProgressHUD.showError(withStatus: "出现错误, 请重试")
                    }
                })
                break
            case 2:
                MXManager.sharedInstance.createURLQRCodeVC(parameters: ["origin": "MainViewController"], completion: { (urlVC: URLQRCodeViewController?) in
                    if urlVC != nil {
                        self.navigationController?.pushViewController(urlVC!, animated: true)
                    } else {
                        SVProgressHUD.showError(withStatus: "出现错误, 请重试")
                    }
                })
                break
            case 3:
                MXManager.sharedInstance.createImageQRCodeVC(parameters: ["origin": "MainViewController"], completion: { (imgVC: ImageQRCodeViewController?) in
                    if imgVC != nil {
                        self.navigationController?.pushViewController(imgVC!, animated: true)
                    } else {
                        SVProgressHUD.showError(withStatus: "出现错误, 请重试")
                    }
                })
                break
            case 4:
                MXManager.sharedInstance.createBatchTextQRCodeVC(parameters: ["origin": "MainViewController"], completion: { (batchTextVC: BatchTextQRCodeViewController?) in
                    if batchTextVC != nil {
                        self.navigationController?.pushViewController(batchTextVC!, animated: true)
                    } else {
                        SVProgressHUD.showError(withStatus: "出现错误, 请重试")
                    }
                })
                break
            case 5:
                break
            case 6:
                break
                
            default:
                break
            }
        }
        // History
        let hisView = HistoryView.init(frame: CGRect.init())
        self.historyView = hisView
        self.view.addSubview(self.historyView)
        self.historyView.layer.cornerRadius = 5
        self.historyView.layer.masksToBounds = true
        self.historyView.layer.shadowColor = UIColor.black.cgColor
        self.historyView.layer.shadowOpacity = 0.8
        self.historyView.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.equalTo(self.toolView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(HistoryCellHeight + 10)
        }
        self.historyView.clicked = {(type) -> Void in
            print("Clicked Type is \(type)")
            if type == .generate {
                
            } else {
                
            }
        }
        // Init Ads
        self.bannerView = GADBannerView.init(adSize: GADAdSizeFromCGSize(CGSize(width: self.view.bounds.width - 40, height: 40)))
        self.bannerView.adUnitID = "ca-app-pub-2790220402556649/4392159747"
        self.bannerView.delegate = self
        self.bannerView.rootViewController = self
        self.bannerView.translatesAutoresizingMaskIntoConstraints = false

        // loading from Google
        self.loadAds()
    }
    
    // MARK: Actions
    @objc func gotoScan() {
        
        MXManager.sharedInstance.createScanVC(parameters: ["origin": "MainViewController"]) { (scanVC : ScanViewController?) in
            if scanVC != nil {
                // slide the page
                self.navigationController?.pushViewController(scanVC!, animated: true)
            } else {
                SVProgressHUD.showError(withStatus: "无法打开摄像头, 请稍后再试")
            }
        }
    }
    
    // MARK: Ad
    private func loadAds() {
        let request = GADRequest.init()
        request.testDevices = ["41c7324efe5a2e956f50d8dc86ccf610", "Simulator"]
        self.bannerView.load(request)
    }
}

// MARK: Ads
extension MainViewController {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        // Add View And Constraint
        self.view.addSubview(self.bannerView)
        self.view.addConstraints([NSLayoutConstraint(item: self.bannerView as Any,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: self.view,
                                                     attribute: .bottom,
                                                     multiplier: 1,
                                                     constant: -20),
                                  NSLayoutConstraint(item: self.bannerView as Any,
                                                     attribute: .centerX,
                                                     relatedBy: .equal,
                                                     toItem: self.view,
                                                     attribute: .centerX,
                                                     multiplier: 1,
                                                     constant: 0)
            ])
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}
