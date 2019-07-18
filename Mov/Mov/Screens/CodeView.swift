//
//  CodeView.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit

protocol CodeView{
    func buidViewHirarchy()
    func setupContraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView{
    func setupView(){
        buidViewHirarchy()
        setupContraints()
        setupAdditionalConfiguration()
    }
}
