//
//  BlankView.swift
//  Mov
//
//  Created by Miguel Nery on 28/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

import UIKit

public class BlankView: UIView {

    // Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BlankView: ViewCode {
    
    public func addView() {
        // nothing to add
    }
    
    public func addConstraints() {
//        self.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
    }
    
    func additionalSetup() {
        self.backgroundColor = .white
    }
    
}

