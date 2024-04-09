//
//  ContentView.swift
//  MLTextScanner
//
//  Created by Jahnavi Vemuri on 20/03/24.
//

import SwiftUI

struct ScannerOptionsView: View {
    @State private var showCamera = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImageWrapper?
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: { showCamera = true }) {
                Label("Take Photo", systemImage: "camera")
            }
            .buttonStyle(.bordered)
            Button(action: { showImagePicker = true }) {
                Label("Select Photo", systemImage: "photo.on.rectangle")
            }
            .buttonStyle(.bordered)
        }
        .padding(.bottom)
        .fullScreenCover(isPresented: $showCamera) {
            CameraView(showCamera: $showCamera, selectedImage: $selectedImage)
        }
        .fullScreenCover(isPresented: $showImagePicker) {
            ImagePickerView(sourceType: .photoLibrary) { image in
                selectedImage = UIImageWrapper(image: image ?? UIImage())
            }
        }
        .sheet(item: $selectedImage) { imageWrapper in
            if let image = imageWrapper.image {
                ImageFullScreenView(image: image)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerOptionsView()
    }
}
