//
//  GenerateBaseViewController.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/28.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GenerateBaseViewController: UIViewController {

    var bannerView : GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = SceneColor
        self.initSubviews()
    }
    
    private func initSubviews() {
        // Init Ads
        self.bannerView = GADBannerView.init(adSize: GADAdSizeFromCGSize(CGSize(width: self.view.bounds.width - 40, height: 40)))
        self.bannerView.adUnitID = "ca-app-pub-2790220402556649/9696403414"
        self.bannerView.delegate = self
        self.bannerView.rootViewController = self
        self.bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        // loading from Google
        self.loadAds()
    }
    
    // MARK: Ad
    private func loadAds() {
        let request = GADRequest.init()
        request.testDevices = ["41c7324efe5a2e956f50d8dc86ccf610", "Simulator"]
        self.bannerView.load(request)
    }
    
    func gotoGeneratedPage(content: String) {
        
    }
}

extension GenerateBaseViewController : GADBannerViewDelegate {
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
