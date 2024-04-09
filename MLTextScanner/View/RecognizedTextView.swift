//
//  RecognizedTextView.swift
//  MLTextScanner
//
//  Created by Jahnavi Vemuri on 21/03/24.
//

import SwiftUI

struct RecognizedTextView: View {
    let recognizedText: String
    @State private var savedAsFile = false
    @State private var fileShare =  false
    @State private var isSheetPresented =  false
    
    var body: some View {
        VStack{
            Text(recognizedText)
                .padding()
                .navigationTitle("")
            if savedAsFile {
                Button(action: {
                    fileShare =  true
                    isSheetPresented =  true
                }) {
                    Label("Share via Mail", systemImage: "envelope")
                }
                .buttonStyle(.bordered)
            } else {
                Button(action: {
                    savedAsFile = true
                    ScannerFileManager.instance.save(text: recognizedText)
                }) {
                    Label("Save as File", systemImage: "doc.on.doc")
                }
                .buttonStyle(.bordered)
            }
        }
        .fullScreenCover(isPresented: $isSheetPresented, content: {
            if fileShare {
                MailComposeView(isShowing: $isSheetPresented, fileName: Constants.File.fileName)
            } else {
                VStack {
                    HStack {
                        Button(action: {
                            isSheetPresented = false
                        }) {
                            Label("Back", systemImage: "chevron.left")
                        }
                        .padding(.leading)
                        
                        Spacer()
                    }
                    .padding(.top)
                    
                    Spacer()
                    
                    Text("Can't open compose since you haven't configured yet")
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                }
            }
        })
    }
}
