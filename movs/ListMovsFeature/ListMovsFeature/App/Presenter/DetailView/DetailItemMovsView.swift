//
//  DetailItemView.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 17/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

protocol DetailItemMovsView: AnyObject {
    func setTitle(_ title: String)
    func showLoading()
    func hideLoading()
    func fillUp(with viewData: MovsItemViewData)
}
