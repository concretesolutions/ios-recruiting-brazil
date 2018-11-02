//
//  ContainerView.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 29/10/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

class ContainerView: UIView {
  
  override init(frame: CGRect = .zero) {
    super.init(frame: frame)
    backgroundColor = .yellow
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
