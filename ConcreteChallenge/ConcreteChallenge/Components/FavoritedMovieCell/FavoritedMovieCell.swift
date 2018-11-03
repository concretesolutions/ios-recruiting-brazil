//
//  FavoritedMovieCell.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import UIKit

class FavoritedMovieCell: UICollectionViewCell {

    static let identifier : String = "FavoritedMovieCell"
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    var deleteLabel1 = UILabel()
    var deleteLabel2 = UILabel()
    var panGesture : UIPanGestureRecognizer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setup()
    }
    
    private func setup() {
        self.panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.panGesture.delegate = self
        self.addGestureRecognizer(self.panGesture)
        
        setupDeleteLabel(label: self.deleteLabel1)
        setupDeleteLabel(label: self.deleteLabel2)
        
        self.contentView.backgroundColor = .white
    }
    
    func setupDeleteLabel(label: UILabel) {
        label.text = "Delete"
        label.textColor = .white
        label.backgroundColor = .red
        label.cornerRadius = 15
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.clipsToBounds = true
        self.insertSubview(label, belowSubview: self.contentView)
        
    }
    
    func set(movie: Movie) {
        self.image.sd_setImage(with: URL(string: Network.manager.imageDomainLow + movie.imageUrl)!, completed: nil)
        self.title.text = movie.title
        self.movieDescription.text = movie.overview
        self.releaseDate.text = String(movie.year)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.panGesture.state == .changed {
            let point = self.panGesture.translation(in: self)
            let width = self.contentView.frame.width
            let height = self.contentView.frame.height
            
            self.contentView.frame = CGRect(x: point.x, y: 0, width: width, height: height);
            self.deleteLabel1.frame = CGRect(x: point.x - deleteLabel1.frame.size.width - 10, y: 0, width: 100, height: height)
            self.deleteLabel2.frame = CGRect(x: point.x + width + deleteLabel2.frame.size.width - 70, y: 0, width: 100, height: height)
        }
    }
    
    @objc func onPan(_ gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            break
        case .changed:
            self.setNeedsLayout()
        default:
            if abs(gesture.velocity(in: self).x) > 500 {
                let collectionView: UICollectionView = self.superview as! UICollectionView
                let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!
                collectionView.delegate?.collectionView!(collectionView, performAction: #selector(onPan(_:)), forItemAt: indexPath, withSender: nil)
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.setNeedsLayout()
                    self.layoutIfNeeded()
                })
            }
        }
    }

}

extension FavoritedMovieCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return abs((self.panGesture.velocity(in: self.panGesture.view)).x) > abs((self.panGesture.velocity(in: self.panGesture.view)).y)
    }
}
