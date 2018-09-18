//
//  FavoriteRouter.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

struct FavoriteRouter {
    static func pushFavoriteFilterViewController(_ fromViewController: UIViewController?) {
        if let viewController = fromViewController {
            let destineViewController: FavoriteFilterViewController = StoryboadsUtil.Favorite.main.instantiateViewController(withIdentifier: FavoriteFilterViewController.identifier) as! FavoriteFilterViewController
            viewController.navigationController?.pushViewController(destineViewController, animated: true)
        }
    }
}
