//
//  DMImageView.swift
//  DataMovie
//
//  Created by Andre on 02/05/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

@IBDesignable
class DMImageView: UIImageView {
    
    @IBInspectable var isRounded: Bool = false {
        didSet{
            if isRounded {
                layer.masksToBounds = true
                layer.cornerRadius = bounds.height/2
            }
        }
    }
    
    @IBInspectable var isRenderingMode: Bool = false {
        didSet{
            setupImage()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupImage()
    }
    
    func setupImage() {
        if let image = self.image {
            let rederingMode = isRenderingMode ? UIImage.RenderingMode.alwaysTemplate : UIImage.RenderingMode.alwaysOriginal
            self.image = image.withRenderingMode(rederingMode)
        }
        
    }
    
}
