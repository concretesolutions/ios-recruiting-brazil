//
//  EmptyFavoriteView.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 20/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit

class EmptyFavoriteView: UIView {
    // MARK: - IBOutlets
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
}

// MARK: - Setup -
extension EmptyFavoriteView {
    static func instantiate(frame: CGRect, emoji: String, message: String) -> EmptyFavoriteView {
        let view: EmptyFavoriteView = initFromNib(frame: frame)
        view.emojiLabel.text = emoji
        view.messageLabel.text = message
        return view
    }
}
