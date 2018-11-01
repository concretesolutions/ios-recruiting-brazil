//
//  Designer.swift
//  AppMovieTests
//
//  Created by Renan Alves on 31/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import XCTest
import FBSnapshotTestCase

@testable import AppMovie

class DesignerTest: FBSnapshotTestCase {
    
    let controller = UIStoryboard(name: "MoviePlayNow", bundle: nil).instantiateInitialViewController() as! MoviesController
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testFavoriteController() {
//        FBSnapshotVerifyView(controller.view)
        let test = FBSnapshotTestController.self
    }
}
