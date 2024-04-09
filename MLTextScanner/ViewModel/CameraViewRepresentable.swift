//
//  CameraViewRepresentable.swift
//  MLTextScanner
//
//  Created by Jahnavi Vemuri on 21/03/24.
//

import Foundation
import SwiftUI

struct CameraViewRepresentable: UIViewControllerRepresentable {
    @Binding var showCamera: Bool
    @Binding var selectedImage: UIImageWrapper?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = context.coordinator
        return cameraController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(showCamera: $showCamera, selectedImage: $selectedImage)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var showCamera: Bool
        @Binding var selectedImage: UIImageWrapper?
        
        init(showCamera: Binding<Bool>, selectedImage: Binding<UIImageWrapper?>) {
            _showCamera = showCamera
            _selectedImage = selectedImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                selectedImage = UIImageWrapper(image: image)
            }
            showCamera = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            showCamera = false
        }
    }
}
