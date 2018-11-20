//
//  Result.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 20/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
