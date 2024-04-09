//
//  ScannerFileManager.swift
//  MLTextScanner
//
//  Created by Jahnavi Vemuri on 22/03/24.
//

import Foundation

class ScannerFileManager {
    static let instance = ScannerFileManager()
    private init() {
        createFolder()
    }
    
    private func createFolder() {
        guard
            let path = getFolderPath() else {
            print("Error finding path")
            return
        }
        
        if !FileManager.default.fileExists(atPath: path.path()) {
            do {
                try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating folder: \(error)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(path: Constants.File.folderName)
    }
    
    private func getFilePath() -> URL? {
        guard let path = getFolderPath() else { return nil }
        
        return path.appending(path: Constants.File.fileName)
    }
    
    func save(text: String) {
        guard
            let path = getFilePath() else {
            print("Error loading file path")
            return
        }
        
        do {
            try text.write(to: path, atomically: false, encoding: .utf8)
        } catch _ {
            print("Error writing to file")
        }
    }
    
    func get() -> String? {
        var fileContents: String?
        
        guard
            let path = getFilePath() else {
            print("Error loading file path")
            return nil
        }
        
        do {
            fileContents = try String(contentsOf: path, encoding: .utf8)
        } catch _ {
            print("Error reading from file")
        }
        
        return fileContents
    }
}

