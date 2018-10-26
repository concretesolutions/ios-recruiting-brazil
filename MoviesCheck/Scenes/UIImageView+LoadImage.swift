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
            
            DispatchQueue.main.async {
                
                do{
                    //Load image
                    let imgData = try Data(contentsOf: imageUrl)
                    
                    if let img = UIImage(data: imgData){
                        //Save image
                        let imageDataToSave = img.pngData()
                        try imageDataToSave?.write(to: URL(fileURLWithPath: localFilePath!), options: Data.WritingOptions.atomic)
                        
                        //Set loaded image to the curret UIImageView
                        self.image = img
                        
                    }else{
                        print("It wat not possible to load image \(fileName)")
                    }
                    
                }catch{
                    print("It wat not possible to load image \(fileName)")
                }
                
            }
            
        }
        
    }
    
}
