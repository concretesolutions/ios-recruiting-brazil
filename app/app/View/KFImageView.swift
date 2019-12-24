//
//  KFImageView.swift
//  app
//
//  Created by rfl3 on 23/12/19.
//  Copyright © 2019 Renan Freitas. All rights reserved.
//

import UIKit
import Kingfisher

class KFImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setImage(with url: URL, frame: CGRect) {
        self.kf.setImage(with: url,
                                   placeholder: UIImage(named: "favorite"),
                                   options: [.transition(.fade(0.2))])
    }
    
}
