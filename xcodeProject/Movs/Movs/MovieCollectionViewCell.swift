//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 09/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    private let titleViewHeightMultiplier: CGFloat = 0.20
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var favorite: UIImageView!
    @IBOutlet weak var titleView: UIView!
    
    private var gradientView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleView.backgroundColor = UIColor.clear
        self.titleView.insertSubview(self.gradientView, at: 0)
    }
    
    func onCollectionViewLayoutUpdate(cellSize: CGSize) {
        self.buildGradientView(cellSize: cellSize)
    }
    
    private func buildGradientView(cellSize: CGSize) {
        self.gradientView.removeFromSuperview()
        
        self.gradientView = UIView()
        let gradientLayer = CAGradientLayer()
        
        let frameHeight = cellSize.height * titleViewHeightMultiplier
        let gradientFrame = CGRect(x: 0.0, y: 0.0, width: cellSize.width, height: frameHeight)
        
        self.gradientView.frame = gradientFrame
        gradientLayer.frame = gradientFrame
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.locations = [0.0, 0.45, 1.0]
        
        let bgColor = UIColor(red: 0.137, green: 0.137, blue: 0.215, alpha: 1.0)
        gradientLayer.colors = [
            bgColor.withAlphaComponent(0.0).cgColor,
            bgColor.withAlphaComponent(0.75).cgColor,
            bgColor.cgColor
        ]
        
        self.gradientView.layer.addSublayer(gradientLayer)
        self.titleView.insertSubview(self.gradientView, at: 0)
    }
}
