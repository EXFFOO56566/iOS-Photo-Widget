//
//  ContentView.swift
//  Photo Widget
//
//  Created by S3soft on 22/09/2020.
//

import SwiftUI
import Photos
import GoogleMobileAds
import S3SwiftUIAppRater

struct ContentView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var photosViewModel: PhotosViewModel
    
    var admobInsterstitialVC:AdmobInsterstitialVC = AdmobInsterstitialVC()
    
    @State private var modalSettings = false
    @State private var isShowPhotoLibrary = false
    @State private var assets: [PHAsset]?
    
    @State private var isEditing = false
    
    private var columnsGrid : [GridItem] {
        var arr = [GridItem]()
        for _ in 0..<columnGridNumber {
            arr.append(GridItem(.flexible()))
        }
        return arr
    }

    var body: some View {
        NavigationView {
            
            ZStack(alignment: .bottom) {
                
                ScrollView {
                    LazyVGrid(columns: columnsGrid) {
                        ForEach(photosViewModel.listPhotoViewModel, id: \.self) { vm in
                            
                            if isEditing {
                                
                                Image(uiImage: Helper.getImgFromUserDefaults(key: vm.photoId))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.imageBoxSize, height: UIScreen.imageBoxSize)
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                                
                                    .overlay(
                                        Button(action: {
                                            self.photosViewModel.removeImage2(photoID: vm.photoId)
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.red)
                                                .padding(10)
                                        }
                                        , alignment: .topLeading)
                            } else {
                                Image(uiImage: Helper.getImgFromUserDefaults(key: vm.photoId))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.imageBoxSize, height: UIScreen.imageBoxSize)
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                            }
                        } // Foreach
                    } // LazyVGrid
                } // Scrollviwe
                
                
                VStack(alignment: .center, spacing: 0) {
                    Button(action: {
                        self.isShowPhotoLibrary = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 20))

                        }
                        .frame(minWidth: 0, maxWidth: 60, minHeight: 0, maxHeight: 60)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .padding()
                    }
                    .sheet(isPresented: $isShowPhotoLibrary) {
                        ImagePicker(assets: self.$assets)
                    }
                    
                    if showBannerAds {
                        AdmobBannerVC()
                            .frame(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height, alignment: .center)
                    }
                }
            } // ZStack
            .navigationBarTitle("Photo Widget: Pro", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        isEditing.toggle()
                    }, label: {
                        Image(systemName: isEditing ? "xmark" : "square.and.pencil")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }),
                trailing:
                    Button(action: {
                        self.modalSettings.toggle()
                    }, label: {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 24, height: 24)
                    })
                    .sheet(isPresented: $modalSettings) {
                        SettingsView()
                            .environmentObject(self.photosViewModel)
                    }
            )
        }
        .onChange(of: assets ?? nil) { newValue in
            
            if let newValue = newValue {
                for asset in newValue {

                    asset.image(completionHandler: {(img) in
                        photosViewModel.appendImage2(uImage: img)
                    })
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                // FULL SCREEN AD OPTION
                if showInsterstitialAdsOption {
                    self.admobInsterstitialVC.showAd()
                }
            }
        }
        .onAppear() {
            S3SwiftUIAppRater.usesUntilPrompt = usesUntilPrompt
            S3SwiftUIAppRater.launch()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PhotosViewModel())
    }
}


extension PHAsset {

    func image(completionHandler: @escaping (UIImage) -> ()){
        
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        var thumbnail = UIImage()
        
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact
        
        
        manager.requestImage(for: self, targetSize: CGSize(width: 1000, height: 1000), contentMode: .aspectFit, options: options, resultHandler: {(result, info)->Void in
            thumbnail = result!
            
            completionHandler(thumbnail)
        })
    }
}
