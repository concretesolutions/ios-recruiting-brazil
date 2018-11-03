//
//  CardContentView.swift
//  AppStoreHomeInteractiveTransition
//
//  Created by Wirawit Rueopas on 3/4/2561 BE.
//  Copyright © 2561 Wirawit Rueopas. All rights reserved.
//

import UIKit

protocol CardContentViewDelegate {
    func saveTapped()
}

@IBDesignable final class CardContentView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var saveButton: UIButton!

    @IBOutlet weak var imageToTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var imageToLeadingAnchor: NSLayoutConstraint!
    @IBOutlet weak var imageToTrailingAnchor: NSLayoutConstraint!
    @IBOutlet weak var imageToBottomAnchor: NSLayoutConstraint!
    
    var delegate: CardContentViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadView()
        commonSetup()
    }

    private func commonSetup() {
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        self.layer.applySketchShadow(color: .black, alpha: 0.6, x: 0, y: 0, blur: 10, spread: 0)
        
        self.cornerRadius = 15
        
        
        setFontState(isHighlighted: false)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if Int(self.saveButton.alpha) == 0 {
            self.setSaveButton(isSaved: true)
        } else {
            self.setSaveButton(isSaved: false)
        }
        
        self.delegate?.saveTapped()
    }
    
    func set(movie: Movie) {
        self.imageView.imageForURL(URL(string: Network.manager.imageDomainLow + movie.imageUrl))
        self.movieTitle.text = movie.title
        
        self.setSaveButton(isSaved: movie.isSaved)
        
        self.saveButton.isExclusiveTouch = true
    }
    
    func setSaveButton(isSaved: Bool) {
        if isSaved {
            self.saveButton.tintColor = .green
            self.saveButton.alpha = 1
        } else {
            self.saveButton.tintColor = .gray
            self.saveButton.alpha = 0.6
        }
    }
    
    private func loadView()  {
        let xib = Bundle.main.loadNibNamed("CardContentView", owner: self, options: nil)?.first as! UIView
        xib.frame = self.bounds
        xib.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xib)
    }

    func setFontState(isHighlighted: Bool) {
        if isHighlighted {
            self.movieTitle.font = UIFont.systemFont(ofSize: 36 * 0.96, weight: .bold)
        } else {
            self.movieTitle.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        }
    }
}
