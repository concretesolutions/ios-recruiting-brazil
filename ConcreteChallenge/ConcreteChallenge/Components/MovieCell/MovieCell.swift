//
//  MovieCell.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var disabledHighlightedAnimation = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
        
    }
    
    func setup() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .init(width: 0, height: 4)
        self.layer.shadowRadius = 12
    }
    
    func set(movie: Movie) {
        self.image?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original/\(movie.backdrop_path ?? "")")!, placeholderImage: UIImage(named: "imageError.png"), options: .cacheMemoryOnly) { (_, err, _, _) in
            if err != nil {
                self.image.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original/\(movie.poster_path ?? "")")!, completed: nil)
            }
        }
        self.title.text = movie.title
        self.saveButton.isEnabled = !(movie.saved ?? true)
    }
    
    func resetTransform() {
        self.transform = .identity
    }
    
    func freezeAnimations() {
        disabledHighlightedAnimation = true
        self.layer.removeAllAnimations()
    }
    
    func unfreezeAnimations() {
        disabledHighlightedAnimation = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }
    
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)?=nil) {
        if self.disabledHighlightedAnimation {
            return
        }
        let animationOptions: UIView.AnimationOptions = true
            ? [.allowUserInteraction] : []
        if isHighlighted {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                            self.transform = .init(scaleX: 0.96, y: 0.96)
            }, completion: completion)
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                            self.transform = .identity
            }, completion: completion)
        }
    }
}
