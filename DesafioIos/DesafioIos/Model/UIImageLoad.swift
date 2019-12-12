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
    func loadImageMovie(_ dest:String , width:Int){
        fetchimage(completion: { (data) in
            if let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }, dest: dest, width: width)
    }
}
