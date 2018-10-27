//
//  UIImageView+LoadImage.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

extension UIImageView{
    
    /**
     Load imagem from URL and save it to local cache, if the image already exist in chache it will be loaded directly from cache
     */
    func loadImage(fromURL urlString:String){
        
        guard let imageUrl = URL(string: urlString) else{
            print("invalid image URL")
            return
        }
        
        let fileName = imageUrl.lastPathComponent
        
        let pathsUsr = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        let localFilePath = pathsUsr.first?.appending(fileName)
        
        let fileExists = FileManager.default.fileExists(atPath: localFilePath!)
        
        if(fileExists){
            
            //Load existent file for fastest load experience
            image = UIImage(contentsOfFile: localFilePath!)
            
        }else{
            
            //Image dosent exist in local cache, load from web
            self.image = UIImage(named: "loadingImage")
            
            URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
                
                if error != nil { return }
                
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    self.cacheImage(img: image!, localFilePath: localFilePath!)
                    self.image = image
                })
                
            }).resume()
            
        }
        
    }
    
    func cacheImage(img:UIImage, localFilePath:String){
        
        //Save image
        do{
            let imageDataToSave = img.pngData()
            try imageDataToSave?.write(to: URL(fileURLWithPath: localFilePath), options: Data.WritingOptions.atomic)
        }catch{
            print("It wat not possible to cache the image")
        }
        
    }
    
}
