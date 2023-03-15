//
//  AdmobInsterstitialVC.swift
//  Photo Widget
//
//  Created by muhammed on 01/10/2020.
//

import Foundation
import SwiftUI
import GoogleMobileAds

final class AdmobInsterstitialVC:NSObject, GADInterstitialDelegate{
    var interstitial:GADInterstitial = GADInterstitial(adUnitID: adMobInsterstitialID)
    
    override init() {
        super.init()
        LoadInterstitial()
    }
    
    func LoadInterstitial(){
        let req = GADRequest()
        self.interstitial.load(req)
        self.interstitial.delegate = self
    }
    
    func showAd(){
        if self.interstitial.isReady{
            
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

            if var topController = keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }

                self.interstitial.present(fromRootViewController: topController)
            }
        }
       else{
           print("Not Ready")
       }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.interstitial = GADInterstitial(adUnitID: adMobInsterstitialID)
        LoadInterstitial()
    }
}
