//
//  ReportView.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 22/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class ReportView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initVariables()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initVariables()
    }
    
    private func initVariables(){
        Bundle.main.loadNibNamed("ReportView", owner: self, options: nil)
        self.frame = self.bounds
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
