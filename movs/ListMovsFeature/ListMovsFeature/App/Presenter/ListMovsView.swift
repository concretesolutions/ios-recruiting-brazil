//
//  ListMovsView.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation
import UIKit

protocol ListMovsView: AnyObject {
    func setTitle(_ text: String)
    func setItemBar(image: UIImage?)
    func showEmptyCard(message: String)
    func showSuccess(viewData: MovsListViewData)
    func showErrorCard()
    func showLoading()
    func hideLoading()
    //func showSuccessCard(viewData: T)
}
