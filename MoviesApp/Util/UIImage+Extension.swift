//
//  UIImage+Extension.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 22/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    
    enum poster{
        
        static var notAvailable:UIImage{
            return UIImage(named: "poster_notAvailable")!
        }
        
    }
    
    enum favorite{
        
        static var fullHeart:UIImage{
            return UIImage(named: "favorite_full_icon")!
        }
        
        static var grayHeart:UIImage{
            return UIImage(named: "favorite_gray_icon")!
        }
        
    }
    
    enum icon{
        
        static var list:UIImage{
            return UIImage(named: "list_icon")!
        }
        
        static var favorite:UIImage{
            return UIImage(named: "favorite_empty_icon")!
        }
        
        static var filter:UIImage{
            return UIImage(named: "FilterIcon")!
        }
        
        static var search:UIImage{
            return UIImage(named: "search_icon")!
        }
        
    }
    
    enum error{
        
        static var noResults:UIImage{
            return UIImage(named: "noResults")!
        }
        
        static var generic:UIImage{
            return UIImage(named: "Group")!
        }
        
    }
    
}
