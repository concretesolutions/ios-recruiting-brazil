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
    
    let cache = ImageCache()
    
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
    
    func testAssetsGetImageShouldGetRemoteImage() {
        let urlPath = "https://image.tmdb.org/t/p/w92/nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg"
        XCTAssertNotNil(Assets.getImage(from: urlPath))
    }
    
    func testAssetsGetImageShouldReturnNilBecauseOfBadURL() {
        let urlPath = ""
        XCTAssertNil(Assets.getImage(from: urlPath))
    }
    
    func testImageCacheShouldGetImageFromServer() {
        let urlPath = "https://image.tmdb.org/t/p/w92/nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg"
        let exp = self.expectation(description: "success")
        self.cache.getImage(for: urlPath) { img in
            if let _ = img {
                exp.fulfill()
            }
        }
        self.wait(for: [exp], timeout: 2.0)
    }
    
    func testImageCacheShouldGetImageFromCache() {
        
        let urlPath = "https://image.tmdb.org/t/p/w92/nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg"
        let exp = self.expectation(description: "finish")
        
        XCTAssertTrue(self.cache.imagesCount == 0)
        self.cache.getImage(for: urlPath) { img in
            if let _ = img {
                exp.fulfill()
            }
        }
        self.wait(for: [exp], timeout: 2.0)
        
        XCTAssertTrue(self.cache.imagesCount == 1)
        self.cache.getImage(for: urlPath) { img in
            XCTAssertNotNil(img)
        }
    }
}
