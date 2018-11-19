//
//  ErrorView.swift
//  Movs
//
//  Created by Victor Rodrigues on 19/11/18.
//  Copyright © 2018 Victor Rodrigues. All rights reserved.
//

import UIKit

class ErrorView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textMessage: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commomInit()
    }
    
    private func commomInit() {
        Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
