//
//  Helpers.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 12/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import Foundation

func formateYear(date:String) -> String{
    let parts:[String] = date.components(separatedBy: "-")
    return parts[0]
}
func formatGenres(list:[Int]) -> String{
    var value = ""
    for id in list{
        for genre in ManegerApiRequest.genres{
            if genre.id == id{
                value.append(genre.name)
                value.append(",")
            }
        }
    }
    value.removeLast()
    return value
}
