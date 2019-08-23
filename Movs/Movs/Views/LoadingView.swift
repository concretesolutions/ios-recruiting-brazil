//
//  LoadingView.swift
//  Movs
//
//  Created by Gustavo Caiafa on 14/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    @IBOutlet var masterView: UIView!
    
    required init?(coder aDecoder: NSCoder) { // para xib ou storyboard
        super.init(coder: aDecoder)
        configuracao()
    }
    
    override init(frame: CGRect) { // para inicializacao por codigo
        super.init(frame: frame)
        configuracao()
    }
    
    private func configuracao(){
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        addSubview(masterView)
        masterView.frame = self.bounds
        masterView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }

}
