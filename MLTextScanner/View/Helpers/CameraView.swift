//
//  CameraView.swift
//  MLTextScanner
//
//  Created by Jahnavi Vemuri on 21/03/24.
//

import Foundation
import SwiftUI

struct CameraView: View {
    @Binding var showCamera: Bool
    @Binding var selectedImage: UIImageWrapper?
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    showCamera = false
                }) {
                    Label("Back", systemImage: "chevron.left")
                }
                .padding(.leading)
                
                Spacer()
            }
            
            CameraViewRepresentable(showCamera: $showCamera, selectedImage: $selectedImage)
        }
    }
}
