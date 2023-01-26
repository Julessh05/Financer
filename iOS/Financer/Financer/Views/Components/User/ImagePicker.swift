//
//  ImagePicker.swift
//  Financer
//
//  Created by Julian Schumacher on 21.01.23.
//

import Foundation
import SwiftUI
import PhotosUI

// Solution from: https://developer.apple.com/forums/thread/651743
/// The Image Picker struct to pick Images from the Library
internal struct ImagePicker : UIViewControllerRepresentable {
    
    /// The Configuration for this View
    internal let conf : PHPickerConfiguration
    
    /// The picked Image
    @Binding internal var pickedImage : UIImage?
    
    /// Whether this View is shown or not.
    @Binding internal var isPresented : Bool
    
    internal func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: conf)
        controller.delegate = context.coordinator
        return controller
    }
    
    internal func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // TODO: add Code
    }
    
    internal func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator(self)
    }
}

/// Coordinator class for this ImagePicker
internal final class ImagePickerCoordinator : PHPickerViewControllerDelegate {
    
    /// The Parent Struct for this
    private let parent : ImagePicker
    
    init(_ parent : ImagePicker) {
        self.parent = parent
    }
    
    internal func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        parent.isPresented = false
        guard let provider = results.first?.itemProvider else { return }
        if provider.canLoadObject(ofClass: UIImage.self) {
            provider.loadObject(ofClass: UIImage.self) {
                image, _ in
                self.parent.pickedImage = image as? UIImage
            }
        }
    }
}
