//
//  AdmobBannerVC.swift
//  Photo Widget
//
//  Created by muhammed on 01/10/2020.
//

import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

final class AdmobBannerVC: UIViewControllerRepresentable  {

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)

        let viewController = UIViewController()
        view.adUnitID = adMobBannerID
        view.rootViewController = viewController
        view.delegate = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
            // Tracking authorization completed. Start loading ads here.
            view.load(GADRequest())
        })
        

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}


extension UIViewController: GADBannerViewDelegate {
    public func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("ad loaded")
    }

    public func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
       print("fail ad")
       print(error)
    }
}
