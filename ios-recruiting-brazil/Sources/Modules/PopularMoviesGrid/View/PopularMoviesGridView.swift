//
//  PopularMoviesGridView.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import UIKit

final class PopularMoviesGridView: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .red
        let button: UIButton = UIButton(frame: CGRect(x: view.bounds.width / 2.0-50.0, y: view.bounds.height / 2.0, width: 100.0, height: 50.0))
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(pushToNextVC), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func pushToNextVC() {
        let newVC = UIViewController()
        newVC.view.backgroundColor = UIColor.red
        self.navigationController?.pushViewController(newVC, animated:
            true)
    }
}
