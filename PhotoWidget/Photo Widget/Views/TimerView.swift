//
//  TimerView.swift
//  Photo Widget
//
//  Created by S3soft on 24/09/2020.
//

import SwiftUI

struct TimerView: View {
    
    // MARK: - PROPERTIES
    
    // Time data for countdown
    let timers: [Int] = [5, 10, 15, 30, 45, 60, 90, 120, 150, 180, 240, 300, 360, 540, 720, 1440].map { $0 * 60 }
    
    var hapticImpact = UIImpactFeedbackGenerator(style: .medium)
    @State var visible = true
    
    @EnvironmentObject var photosViewModel: PhotosViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 10) {
                if visible {
                    ForEach(timers, id: \.self) {item in
                        Button(action: {
                            self.photosViewModel.setTimer(timer: item)
                            self.hapticImpact.impactOccurred()
                            visible.toggle()
                            visible.toggle()
                        }) {
                            Text("\(timeCustomizedString(time: TimeInterval(item)))")
                                .foregroundColor((Helper.getTimer() == item) ? Color.blue : Color.gray)
                            .padding(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke( (Helper.getTimer() == item) ? Color.blue : Color.gray, lineWidth: 1)
                            )
                        }
                    }
                }
            }
            .padding(10)
        }
    }
}

func timeCustomizedString(time: TimeInterval) -> String {
    
    let hour = Int(time) / 3600
    
    let minute = Int(time) / 60 % 60
    
    if hour > 0 {
        return minute > 0 ? "\(hour)h\(minute)m" :"\(hour)h"
    }
    
    if minute > 0 {
        return "\(minute)m"
    }
    
    return ""
}
