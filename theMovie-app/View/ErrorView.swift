//
//  Error.swift
//  theMovie-app
//
//  Created by Adriel Alves on 14/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import UIKit

enum ErrorEnum {
    case notFound(searchText: String),
    genericError
}

protocol ErrorViewDelegate {
    func errorViewAction()
}

class ErrorView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var ivError: UIImageView!
    @IBOutlet weak var lbError: UILabel!
    @IBOutlet weak var btError: UIButton!
    
    var delegate: ErrorViewDelegate?
    
    var type: ErrorEnum! {
        didSet {
            switch type! {
            case .genericError:
                ivError.image = UIImage(named: "error")
                lbError.text = "Ocorreu um erro, por favor tente novamente"
                btError.isHidden = false
            case .notFound(let searchText):
                ivError.image = UIImage(named: "search_icon")
                ivError.tintColor = .black
                lbError.text = "Sua pesquisa por \(searchText) não houve resultados"
                btError.isHidden = true
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("Error", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func show(type: ErrorEnum,  delegate: ErrorViewDelegate) {
        self.type = type
        self.delegate = delegate
        
    }
  


}
