//
//  UIImageView+Network.swift
//  Movs
//
//  Created by Tiago Chaves on 12/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

let cache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
	
	func setImage(withUrl url: String, placeHolder:String? = "placeholder", completion:((_ success:Bool) -> Void)? = nil){
		
		guard let url = URL(string: url) else{
			DispatchQueue.main.async {
				self.image = nil
			}
			if let comp = completion {
				comp(false)
			}
			return
		}
		
		if let placeHolder = placeHolder {
			DispatchQueue.main.async {
				self.image = UIImage(named: placeHolder)
			}
		}
		
		if let imageFromCache = cache.object(forKey: url as AnyObject) as? UIImage {
			
			DispatchQueue.main.async {
				self.image = imageFromCache
			}
			if let comp = completion {
				comp(true)
			}
		}else{
			
			URLSession.shared.dataTask(with: url) { data, response, error in
				
				if error == nil, let data = data {
					
					if let imageToCache = UIImage(data: data) {
						
						cache.setObject(imageToCache as AnyObject, forKey: url as AnyObject)
						
						DispatchQueue.main.async {
							self.image = imageToCache
						}
						
						if let comp = completion {
							comp(true)
						}
					}else{
						DispatchQueue.main.async {
							self.image = UIImage(named: "imageError")
						}
						if let comp = completion {
							comp(false)
						}
					}
				}
				}.resume()
		}
	}
}

