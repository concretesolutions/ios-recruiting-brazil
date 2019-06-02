//
//  File.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 02/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import UIKit

extension UIViewController {
    func setColorForNavigationItem() {
        self.navigationController?.navigationBar.tintColor = Colors.blue
        self.navigationController?.navigationBar.tintColor = Colors.blue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.blue]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.blue]
    }
}
