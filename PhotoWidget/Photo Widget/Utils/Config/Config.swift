//
//  Config.swift
//  Photo Widget
//
//  Created by S3soft on 24/09/2020.
//

import Foundation

// MARK: - SYSTEM
// Update your app title, bundle identifier and app group name for your developer account in the targets
let appGroupName = "group.com.s3soft.Photo-Widget"

// Update with your mail address for contact mail in the Settings page
let mail_address = "info@s3soft.com"

// MARK: - ADMOB
// TODO: Replace by your admob banner ID
// TODO: You should also replace ID in Info.plist file, for more detail plase read user manual
//---GOOGLE ADMOB AND IN-APP PURCHASE IDS HERE---//
let adMobBannerID = "ca-app-pub-3940256099942544/2934735716"
let adMobInsterstitialID = "ca-app-pub-3940256099942544/4411468910"
// Set it false if you don't want to show ads
let showBannerAds = true
// If you want to show full screen ad when user finish selects photos, set it false if you don't want to show
let showInsterstitialAdsOption = true


// MARK: -UI
// You can update the grid number in the home page
let columnGridNumber = 2


// MARK: - HOW TO SCREEN
// Update "How to Add Widget" photos
// 1-> Open Assets.xcassets and navigate to onboard directory.
// 2-> Update the photos. Do not change photos name
//
// Update "How to Add Widget" texts
let howtoText1 = "Add your photos"
let howtoText2 = "Touch and hold an empty area on your screen and tap the plus button in the upper corner"
let howtoText3 = "You’ll bring up a menu of existing widgets. Find 'Photo Widget: Pro' and tap"
let howtoText4 = "Swipe left and right to choose the widget’s size and shape."
let howtoText5 = "Congratulations!"


// MARK: App Rater
let usesUntilPrompt = 5 /// Shows review request if users launch more than usesUntilPrompt times.
