//
//  PhotosViewModel.swift
//  Photo Widget
//
//  Created by S3soft on 22/09/2020.
//

import Foundation
import UIKit
import SwiftUI
import WidgetKit


final class PhotoViewModel: NSObject, ObservableObject {
    
    // MARK: - PROPERTIES
    @Published var photoId: String
    @Published var imageLoaded: Bool = false
    
    // MARK: - SETUP
    init(photoId: String) {
        self.photoId = photoId
    }
    
}

final class PhotosViewModel: NSObject, ObservableObject {
    
    // MARK: - PROPERTIES
    @Published var listPhotoViewModel = [PhotoViewModel]()
    
    @Published var photos = [Image]()
    
    
    // MARK: - SETUP
    override init() {
        super.init()
        
        let imageIDs = Helper.getImageIDArrayFromUserDefault()
        
        var tempArr = [PhotoViewModel]()
        for itemID in imageIDs {
            tempArr.append(PhotoViewModel(photoId: itemID))
        }
        self.listPhotoViewModel = tempArr
        
    }
    
    private func saveIntoUserDefaults() {
        if let userDefaults = UserDefaults(suiteName: appGroupName) {
            
            var tempArr = [String]()
            for vm in listPhotoViewModel {
                tempArr.append(vm.photoId)
            }
            
            let data = try! JSONEncoder().encode(tempArr)
            userDefaults.set(data, forKey: userDefaultsPhotosURLKey)
        }
        
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    
    func appendImage2(uImage: UIImage) {
        let uuid = "\(UUID())"
        self.listPhotoViewModel.append(PhotoViewModel(photoId: uuid))
        self.saveIntoUserDefaults()
        
        if let userDefaults = UserDefaults(suiteName: appGroupName) {
            
            if let jpegRepresentation = uImage.jpegData(compressionQuality: 0.5) {
                print(jpegRepresentation)
                
                userDefaults.set(jpegRepresentation, forKey: uuid)
            }
        }
    }
    

    func removeImage2(photoID: String) {
        if let foo = self.listPhotoViewModel.enumerated().first(where: {$0.element.photoId == photoID}) {
           // do something with foo.offset and foo.element
            self.listPhotoViewModel.remove(at: foo.offset)
            self.saveIntoUserDefaults()
            
            if let userDefaults = UserDefaults(suiteName: appGroupName) {
                userDefaults.removeObject(forKey: photoID)
            }
        }
    }
    
    func setTimer(timer: Int) {
        if let userDefaults = UserDefaults(suiteName: appGroupName) {
            userDefaults.setValue(timer, forKey: userDefaultsTimerKey)
        }
    }
}
