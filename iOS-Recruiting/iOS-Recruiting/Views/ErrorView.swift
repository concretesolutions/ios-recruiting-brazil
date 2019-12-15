//
//  ErrorView.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 15/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import UIKit

protocol ErrorDelegate: UIViewController {
    func retry()
}

class ErrorView: UIView, NibLoadableView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    internal weak var delegate: ErrorDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed(ErrorView.nibName, owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
       
    }
    
    internal func configure(type: errorType) {
        switch type {
        case .undefined:
            self.iconImage.image = #imageLiteral(resourceName: "error-icon")
            self.errorLabel.text = "Um erro ocorreu. Por favor tente novamente"
            self.retryButton.setTitle("Tentar novamente", for: .normal)
        default:
            break
        }
    }
    
    @IBAction func retryTapped(_ sender: UIButton) {
        self.delegate?.retry()
    }
}
