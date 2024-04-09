//
//  ImageFullScreenView..swift
//  MLTextScanner
//
//  Created by Jahnavi Vemuri on 21/03/24.
//

import SwiftUI
import Vision

struct ImageFullScreenView: View {
    let image: UIImage
    @Environment(\.presentationMode) var presentationMode
    @State public var recognizedText: String = "" // Store recognized text
    @State public var showRecognizedText: Bool = false // Control navigation to next screen
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Label("Back", systemImage: "chevron.left")
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
                Spacer()
                
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                VStack(spacing: 10) {
                    Button(action: {
                        recognizeText()
                    }) {
                        Label("Scan Text", systemImage: "scanner")
                    }
                    .buttonStyle(.bordered)
                    
                    NavigationLink(destination: RecognizedTextView(recognizedText: recognizedText), isActive: $showRecognizedText) {
                        EmptyView()
                    }
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Label("Capture Again", systemImage: "camera")
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.bottom)
                .padding(.horizontal)
            }
        }
    }
}
