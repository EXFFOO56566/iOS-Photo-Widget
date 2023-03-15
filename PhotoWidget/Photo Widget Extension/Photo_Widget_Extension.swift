//
//  Photo_Widget_Extension.swift
//  Photo Widget Extension
//
//  Created by S3soft on 23/09/2020.
//

import WidgetKit
import SwiftUI

let samplePhoto = UIImage(named: "preview")!

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), photoKey: "", photo: samplePhoto)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let listPhotoID = Helper.getImageIDArrayFromUserDefault()
        
        if(!listPhotoID.isEmpty) {
            let entry = SimpleEntry(date: Date(), photoKey: listPhotoID[0], photo: nil)
            completion(entry)
        } else {
            let entry = SimpleEntry(date: Date(), photoKey: "", photo: samplePhoto)
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let listPhotoID = Helper.getImageIDArrayFromUserDefault()
        
        let timer = Helper.getTimer() // in seconds
        
        for hourOffset in 0 ..< listPhotoID.count {
            
            let entryDate = Calendar.current.date(byAdding: .second, value: (hourOffset*timer), to: currentDate)!
            
            let entry = SimpleEntry(date: entryDate, photoKey: listPhotoID[hourOffset], photo: nil)
            
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let photoKey: String
    let photo: UIImage?
}

struct Photo_Widget_ExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            if entry.photo != nil {
                Image("preview")
                    .resizable()
                    .scaledToFill()
            } else {
                if Helper.getRandom() {
                    getRandomImage()
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(uiImage: Helper.getImgFromUserDefaults(key:entry.photoKey))
                        .resizable()
                        .scaledToFill()
                }
            }
        }
    }
    
    func getRandomImage() -> Image {
        let listPhotoID = Helper.getImageIDArrayFromUserDefault()
        let randomImg = Int.random(in: 0..<listPhotoID.count)
        let uimage = Helper.getImgFromUserDefaults(key: listPhotoID[randomImg])
        return Image(uiImage: uimage)
    }
    
}

@main
struct Photo_Widget_Extension: Widget {
    let kind: String = "Photo_Widget_Extension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Photo_Widget_ExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("Photo Widget: Pro")
        .description("")
    }
}

struct Photo_Widget_Extension_Previews: PreviewProvider {
    static var previews: some View {
        Photo_Widget_ExtensionEntryView(entry: SimpleEntry(date: Date(), photoKey: "", photo: samplePhoto))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
