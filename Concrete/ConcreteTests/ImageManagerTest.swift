//
//  ImageManagerTest.swift
//  ConcreteTests
//
//  Created by Kaique Magno Dos Santos on 16/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import XCTest
@testable import Concrete

class ImageManagerTest: XCTestCase {

    func testGetImage() {
        ImageManager.shared.fetchImage(
        from: URL(string: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg")!) { (result) in
            switch result {
            case .success(let image):
                XCTAssert(image.pngData() != nil)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
}
