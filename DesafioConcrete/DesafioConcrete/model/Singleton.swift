//
//  Singleton.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 17/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import Foundation
final class Singleton {
    
    static public let shared = Singleton()
    
    var movies:Array<Movie> = Array<Movie>()
    var genres:Array<Genre> = Array<Genre>()
    var preferidos:Array<Movie> = Array<Movie>()
    
    private init() {
        
    }
    
}
