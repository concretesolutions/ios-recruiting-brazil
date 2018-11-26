//
//  ImageManager.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 16/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class ImageManager {
    
    // MARK: - Properties
    // MARK: Private
    private var cache:NSCache = NSCache<NSString,UIImage>()
    // MARK: Public
    var baseURLPath:String? {
        get{
            return UserDefaults.standard.string(forKey: "ImageManager.baseURLPath")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "ImageManager.baseURLPath")
        }
    }
    
    var defaultImageSize:String? {
        get{
            return UserDefaults.standard.string(forKey: "ImageManager.defaultImageSize")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "ImageManager.defaultImageSize")
        }
    }
    
    static let shared = ImageManager()
    
    // MARK: - Init
    private init() {
        self.defaultImageSize = "w500"
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func fetchImage(from imagePath:String, completion: @escaping (Result<UIImage>) -> Void) {
        
        guard let baseURLPath = self.baseURLPath else {
            Logger.logError(in: self, message: "Could get baseURLPath URL")
            return
        }
        guard let defaultImageSize = self.defaultImageSize else {
            Logger.logError(in: self, message: "Could get defaultImageSize URL")
            return
        }
        
        let fullUrlPath = baseURLPath+defaultImageSize+imagePath
        guard let fullUrl = URL(string: fullUrlPath) else {
            Logger.logError(in: self, message: "Could not initialize URL with path fullUrlPath:\(fullUrlPath)")
            return
        }
        
        if let image = self.cache.object(forKey: fullUrl.absoluteString as NSString) {
            completion(Result.success(image))
        }else{
            URLSession.shared.dataTask(with: fullUrl) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse,
                    httpURLResponse.statusCode == 200,
                    let data = data,
                    error == nil,
                    let image = UIImage(data: data)
                    else {
                        Logger.logError(in: self, message: "Could not load image")
                        if let error = error {
                            completion(Result.failure(error))
                        }else{
                            let httpURLResponse = response as? HTTPURLResponse
                            let error = NSError(domain: fullUrlPath, code: httpURLResponse?.statusCode ?? 404, userInfo: nil)
                            completion(Result.failure(error))
                        }
                        
                        return
                }
                
                self.cache.setObject(image, forKey: fullUrl.absoluteString as NSString)
                
                completion(Result.success(image))
                
                }.resume()
        }
    }
    
    func cleanCache() {
        self.cache = NSCache<NSString,UIImage>()
    }
    
}
