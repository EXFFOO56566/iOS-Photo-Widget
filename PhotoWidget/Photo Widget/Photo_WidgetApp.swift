//
//  Photo_WidgetApp.swift
//  Photo Widget
//
//  Created by S3soft on 22/09/2020.
//

import SwiftUI

extension UIApplication {
    var currentScene: UIWindowScene? {
        connectedScenes
            .first { $0.activationState == .foregroundActive } as? UIWindowScene
    }
}

@main
struct Photo_WidgetApp: App {
    
    init() {
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PhotosViewModel())
        }
    }
}
