//
//  AssetsTests.swift
//  MovsTests
//
//  Created by Gabriel Reynoso on 27/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import XCTest
@testable import Movs

extension Assets {
    var optionalImage: UIImage? { return UIImage(named: self.rawValue) }
}

extension Colors {
    var optionalColor: UIColor? { return UIColor(named: self.rawValue) }
}

class AssetsTests: XCTestCase {
    
    func testAssetsShouldNotReturnNilWhenInvokingAnImage() {
        XCTAssertNotNil(Assets.checkIcon.optionalImage)
        XCTAssertNotNil(Assets.errorIcon.optionalImage)
        XCTAssertNotNil(Assets.favoriteEmptyIcon.optionalImage)
        XCTAssertNotNil(Assets.favoriteFillIcon.optionalImage)
        XCTAssertNotNil(Assets.favoriteGrayIcon.optionalImage)
        XCTAssertNotNil(Assets.filterIcon.optionalImage)
    }

    func testColorsShouldNotReturnNilWhenInvokingACustomColor() {
        XCTAssertNotNil(Colors.mainYellow.optionalColor)
        XCTAssertNotNil(Colors.darkBlue.optionalColor)
        XCTAssertNotNil(Colors.orange.optionalColor)
    }
}
