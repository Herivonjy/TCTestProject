//
//  UIImageView+TC.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 11/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import UIKit
import Reachability

protocol ImageDownloaderDelegate {
    func didDownloadImage(image:UIImage)
}

extension UIImageView {
    
    func setImageURL(url:String?) {
        guard let url = url else { return }
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        
        if let data = self.loadLocalImage(url: url) {
            self.image = UIImage(data: data)
        }
        else {
            self.addSubview(activityIndicator)
            activityIndicator.center = self.center
            activityIndicator.startAnimating()
        }
        
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .returnCacheDataElseLoad
        URLSession.shared.dataTask( with: NSURL(string:url)! as URL, completionHandler: { [weak self]
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                guard let strongSelf = self else {return}
                activityIndicator.stopAnimating()
                if let data = data {
                    strongSelf.contentMode = .scaleAspectFit
                    strongSelf.image = UIImage(data: data)
                    strongSelf .saveToLocal(imageData: data, url: url)
                }
            }
        }).resume()
    }
    
    func loadLocalImage(url:String?) -> Data? {
        guard let url = url else {
            return nil
        }
        let  filename = url.components(separatedBy: "/").last!
        let pictureManager = PictureManager()
        return pictureManager.getImageData(name: filename)
    }
    
    func saveToLocal(imageData:Data?, url:String?) {
        if let imageData = imageData, let url = url {
            let  filename = url.components(separatedBy: "/").last
            let pictureManager = PictureManager()
            let _ = pictureManager.saveImage(name: filename!, imageData: imageData)
        }
    }
    
}
