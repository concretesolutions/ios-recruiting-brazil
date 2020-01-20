//
//  CollectionCellMovie.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 19/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import Foundation
import UIKit

class CollectionCellMovie{
    var movie:Movie?
    var image:UIImage?
    init(movie:Movie,image:UIImage?){
        self.movie = movie;
        self.image = image
    }
}
