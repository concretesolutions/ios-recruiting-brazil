//
//  FullScreenView.swift
//  Movs
//
//  Created by Gustavo Caiafa on 19/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import UIKit
import SDWebImage

class FullScreenView: UIView {

    @IBOutlet var masterView: UIView!
    @IBOutlet weak var imgFoto: UIImageView!
    var controller : UIViewController?
    
    required init?(coder aDecoder: NSCoder) { // para xib ou storyboard
        super.init(coder: aDecoder)
        configuracao()
    }
    
    override init(frame: CGRect) { // para inicializacao por codigo
        super.init(frame: frame)
        configuracao()
    }
    
    private func configuracao(){
        Bundle.main.loadNibNamed("FullScreenView", owner: self, options: nil)
        addSubview(masterView)
        masterView.frame = self.bounds
        masterView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func configuraCell(imgUrl: URL?, controller : UIViewController){
        if(imgUrl != nil){
            self.imgFoto.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgFoto.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "imgPlaceholder.jpeg"), options: .refreshCached, completed: nil)
            
            let tapHideFullScreen = UITapGestureRecognizer(target: self, action: #selector(self.dismiss))
            self.masterView.addGestureRecognizer(tapHideFullScreen)
        }
      
        self.controller = controller
    }

    @objc private func dismiss(){
        self.controller?.dismiss(animated: true, completion: nil)
    }
    
}
