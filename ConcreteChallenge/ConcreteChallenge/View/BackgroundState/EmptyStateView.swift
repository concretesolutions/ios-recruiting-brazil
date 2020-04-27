//
//  EmptyStateView.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var retryButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        retryButton.layer.cornerRadius = 4
    }
    
    func set(with configuration: BackgroundStateViewModel) {
        imageView.image = UIImage(named: configuration.image.rawValue)
        titleLabel.text = configuration.title
        
        
        if configuration.subtitle.isEmpty {
            descriptionLabel.isHidden = true
        } else {
            descriptionLabel.isHidden = false
            descriptionLabel.text = configuration.subtitle
        }
        
        if configuration.retry.isEmpty {
            retryButton.isHidden = true
        } else {
            retryButton.isHidden = false
            retryButton.titleLabel?.text = configuration.retry
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
