//
//  UIImageView.swift
//  BasicTemplate
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage? = UIImage(named: "img_placeholder")) {
        image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            image = cachedImage
        } else if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if !error.isNil() {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async { [weak self] in
                        self?.image = placeHolder
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        if let data = data {
                            if let downloadedImage = UIImage(data: data) {
                                imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                                self?.image = downloadedImage
                            }
                        }
                    }
                }
            }).resume()
        }
    }
}
