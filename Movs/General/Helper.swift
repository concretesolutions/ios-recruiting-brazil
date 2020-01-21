//
//  Helper.swift
//  Movs
//
//  Created by Rafael Douglas on 20/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import Foundation
import UIKit

class Helper{
    static func getYearfromDateString(_ date:String) -> String{
        //date passed how parameter with format yyyy-mm-dd
        
        let dateSplitArr = date.components(separatedBy: "-")
        let year = dateSplitArr[0]
        
        return year
    }
}
