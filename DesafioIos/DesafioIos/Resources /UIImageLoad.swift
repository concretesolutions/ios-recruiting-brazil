//
//  UIImageLoad.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 10/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    func loadImageMovie(_ dest:String? , width:Int){
        guard let dest = dest else {
            return
        }
        fetchimage(completion: { (data) in
            if let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }, dest: dest, width: width)
    }
    private func fetchimage(completion: @escaping (_ results: Data) -> Void,dest:String,width:Int){
        var url = URL(fileURLWithPath: "https://image.tmdb.org/t/p/w\(width)/")
        url.appendPathComponent(dest)
        URLSession.shared.dataTask(with: url){
            (data,_,_) in
            do{
                guard let data = data else {
                    print("Error fetching the image! 😢")
                    return
                }
                completion(data)
            }
        }.resume()
        
    }
}
