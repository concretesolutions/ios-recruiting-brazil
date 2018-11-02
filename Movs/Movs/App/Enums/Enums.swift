//
//  Enums.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 01/11/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

enum Result<Value> {
  case success(Value)
  case failure(Error)
}
