//
//  LoadingMoreFooterCollectionReusableView.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 29/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

enum LoadingFooterState {
    case hidden
    case loading
    case thatsAll

    var image: UIImage? {
        switch self {
        case .thatsAll:
            return UIImage(named: "NoSearchResult")
        case .loading:
            return UIImage(named: "NoMovie")
        default:
            return nil
        }
    }
}

class LoadingMoreFooterCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingMoreLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var thatsAllFolksLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.showLoading()
    }

    private func setImage(for state: LoadingFooterState) {
        imageView.image = state.image
    }

    func showLoading(saying text: String = "Carrengando...") {
        hideContent()

        loadingMoreLabel.text = text
        activityIndicator.startAnimating()
        setImage(for: .loading)

        activityIndicator.isHidden = false
        loadingMoreLabel.isHidden = false
    }

    func showThatsAllFolks(saying text: String = "Isso é tudo!") {
        hideContent()

        thatsAllFolksLabel.text = text
        setImage(for: .thatsAll)

        thatsAllFolksLabel.isHidden = false
    }

    func hideContent() {
        activityIndicator.stopAnimating()
        thatsAllFolksLabel.isHidden = true
        activityIndicator.isHidden = true
        loadingMoreLabel.isHidden = true
    }

}
