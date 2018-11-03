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
        setFontState(isHighlighted: false)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        self.saveButton.alpha = self.saveButton.alpha == 1 ? 0.6 : 1
        self.delegate?.saveTapped()
    }
    
    func set(movie: Movie) {
        self.imageView.imageForURL(URL(string: Network.manager.imageDomainLow + movie.imageUrl))
        self.movieTitle.text = movie.title
        self.saveButton.alpha = movie.isSaved ? 0.6 : 1
        self.saveButton.isExclusiveTouch = true
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
