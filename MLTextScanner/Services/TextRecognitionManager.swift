//
//  TextRecognition.swift
//  MLTextScanner
//
//  Created by Jahnavi Vemuri on 21/03/24.
//

import SwiftUI
import Vision

extension ImageFullScreenView {
    func recognizeText() {
        guard let cgImage = image.cgImage else { return }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        let request = VNRecognizeTextRequest { request, error in
            guard error == nil else {
                print("Error recognizing text: \(error!.localizedDescription)")
                return
            }
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                print("No text recognized.")
                return
            }
            
            var recognizedText = ""
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { continue }
                recognizedText += topCandidate.string + "\n"
            }
            
            // Update recognized text and show the next screen
            self.recognizedText = recognizedText
            self.showRecognizedText = true
        }
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Error performing text recognition: \(error.localizedDescription)")
        }
    }
}


