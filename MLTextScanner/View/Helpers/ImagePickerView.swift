//
//  ImagePicker.swift
//  MLTextScanner
//
//  Created by Jahnavi Vemuri on 21/03/24.
//

import Foundation
import SwiftUI

struct ImagePickerView: View {
    var sourceType: UIImagePickerController.SourceType
    var completionHandler: (UIImage?) -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
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
            ImagePickerRepresentable(sourceType: sourceType, completionHandler: completionHandler)
        }
    }
}
