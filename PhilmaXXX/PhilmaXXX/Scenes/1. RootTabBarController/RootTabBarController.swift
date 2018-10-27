//
//  RootTabBarController.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
	
	let viewModel: RootTabBarViewModel
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		viewModel.fetchGenresAndSetInCache()
    }
	
	init(viewModel: RootTabBarViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
