//
//  CodeViewProtocol.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation

protocol CodeView {
	func buildViewHierarchy()
	func setupConstraints()
	func setupAdditionalConfiguration()
	func setupView()
}

extension CodeView {
	func setupView(){
		buildViewHierarchy()
		setupConstraints()
		setupAdditionalConfiguration()
	}
}
