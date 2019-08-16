//
//  FBSnapshotTestCase+Movs.swift
//  MovsTests
//
//  Created by Douglas Silveira Machado on 15/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import FBSnapshotTestCase
import Foundation
import UIKit
import XCTest

extension FBSnapshotTestCase {

    func takeSnapshotsForAllScreens(view: UIView, needWait: Bool) {
        ScreenSize.allCases.forEach { screenSize in
            view.frame = screenSize.value
            FBSnapshotVerifyView(view, identifier: screenSize.rawValue, perPixelTolerance: 3)
            if needWait {
                let expect = expectation(description: "wait view to load")
                _ = XCTWaiter.wait(for: [expect], timeout: 5)
            }
            FBSnapshotVerifyLayer(view.layer, identifier: screenSize.rawValue, perPixelTolerance: 3)
        }
    }
}
