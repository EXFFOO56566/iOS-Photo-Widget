//
//  Helper.swift
//  Photo Widget
//
//  Created by S3soft on 23/09/2020.
//

import SwiftUI
import WidgetKit

let userDefaultsPhotosURLKey = "photosURL"
let userDefaultsTimerKey = "timer"
let userDefaultsIsRandomKey = "isRandom"

struct Helper {
    
    static func getOrgImage(url: URL) -> UIImage {
        if let imageData = try? Data(contentsOf: url) {
            if let image = UIImage(data: imageData) {
                return image
            }
        }
        return UIImage(named: "preview")!
    }
    
    static func getImgFromUserDefaults(key: String) -> UIImage {
        if let userDefaults = UserDefaults(suiteName: appGroupName) {
            if let imageData = userDefaults.object(forKey: key) as? Data,
                let image = UIImage(data: imageData) {
                return image
            }
        }
        
        return UIImage(named: "preview")!
    }

    
    static func getImageIDArrayFromUserDefault() -> [String] {
        
        if let userDefaults = UserDefaults(suiteName: appGroupName) {
            if let data = userDefaults.data(forKey: userDefaultsPhotosURLKey) {
                return try! JSONDecoder().decode([String].self, from: data)
            }
        }
        
        return [String]()
    }
    
    
    static func getTimer() -> Int{
        if let userDefaults = UserDefaults(suiteName: appGroupName) {
            if userDefaults.value(forKey: userDefaultsTimerKey) != nil {
                return userDefaults.integer(forKey: userDefaultsTimerKey)
            }
        }
        
        return 5*60 // Default 5 minute
    }
    
    static func getRandom() -> Bool {
        if let userDefaults = UserDefaults(suiteName: appGroupName) {
            if userDefaults.value(forKey: userDefaultsIsRandomKey) != nil {
                return userDefaults.bool(forKey: userDefaultsIsRandomKey)
            }
        }
        return false
    }
    
    static func setRandom(tag: Bool) {
        if let userDefaults = UserDefaults(suiteName: appGroupName) {
            userDefaults.setValue(tag, forKey: userDefaultsIsRandomKey)
            
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}

