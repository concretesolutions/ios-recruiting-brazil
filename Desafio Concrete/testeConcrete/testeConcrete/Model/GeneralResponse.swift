//
//  GeneralResponse.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 18/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import Foundation

class GeneralResponse<T>{
    public var error:Errors?
    public var success:T?
    init(error:Errors?,success:T?){
        self.error = error
        self.success = success
    }
}
