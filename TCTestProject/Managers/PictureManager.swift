//
//  PictureManager.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 11/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import Foundation

protocol PictureManagerProtocol {
    func getImageData(name: String) -> Data?
    func saveImage(name: String, imageData:Data?) -> Bool
}

class PictureManager: PictureManagerProtocol {
    
    func getImageData(name: String) -> Data? {
        
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        let path = url.path
        var data:Data?
        
        guard fileManager.fileExists(atPath: path) else {
            return nil
        }
        do {
            try  data = Data(contentsOf:url)
            return data
        } catch {
            print("Error : \(error)")
            return nil
        }
    }
    
    func saveImage(name: String, imageData:Data?) -> Bool {
        
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        let path = url.path
        
        guard fileManager.fileExists(atPath: path) else {
            guard
                let imageData = imageData
                else { return false }
            
            fileManager.createFile(atPath: path, contents: imageData, attributes: nil)
            return true
        }
        do {
            try fileManager.removeItem(at:url)
            guard
                let imageData = imageData
                else { return false }
            
            fileManager.createFile(atPath: path, contents: imageData, attributes: nil)
        } catch {
            return false
        }
        return true
    }
}
