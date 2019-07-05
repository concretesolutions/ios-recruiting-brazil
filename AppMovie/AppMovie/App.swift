//
//  App.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 04/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

class App{
    
    //UIApplication
    class final var Delegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //Localizable
    class final func STR(_ string:String) -> String{
        return  NSLocalizedString(string, comment: "")
    }
    
}
