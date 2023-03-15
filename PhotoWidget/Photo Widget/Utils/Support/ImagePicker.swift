//
//  ImagePicker.swift
//  Photo Widget
//
//  Created by S3soft on 22/09/2020.
//

import SwiftUI
import Photos
import Tatsi

struct ImagePicker: UIViewControllerRepresentable {
 
    @Binding var assets: [PHAsset]?
    
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> TatsiPickerViewController {
        
        var config = TatsiConfig.default
        config.singleViewMode = true
        config.showCameraOption = false
        config.supportedMediaTypes = [.image]

        let tatsiPicker = TatsiPickerViewController(config: config)
        tatsiPicker.pickerDelegate = context.coordinator
        tatsiPicker.delegate = context.coordinator
        
        return tatsiPicker
    }
 
    func updateUIViewController(_ uiViewController: TatsiPickerViewController, context: UIViewControllerRepresentableContext<ImagePicker>) {
 
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TatsiPickerViewControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
           self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func pickerViewController(_ pickerViewController: TatsiPickerViewController, didPickAssets assets: [PHAsset]) {
            
            parent.assets = assets
            
            pickerViewController.dismiss(animated: true, completion: nil)
           
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.presentationMode.wrappedValue.dismiss()
        }
     
    
    }
}

