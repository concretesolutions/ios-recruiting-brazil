//
//  BuscaVaziaView.swift
//  Movs
//
//  Created by Gustavo Caiafa on 22/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import UIKit

class BuscaVaziaView: UIView {
    
    @IBOutlet var masterView: UIView!
    @IBOutlet weak var lblMsgErro: UILabel!
    
    required init?(coder aDecoder: NSCoder) { // para xib ou storyboard
        super.init(coder: aDecoder)
        configuracao()
    }
    
    override init(frame: CGRect) { // para inicializacao por codigo
        super.init(frame: frame)
        configuracao()
    }
    
    private func configuracao(){
        Bundle.main.loadNibNamed("BuscaVaziaView", owner: self, options: nil)
        addSubview(masterView)
        masterView.frame = self.bounds
        masterView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
}
