//
//  FavoritesWorkerSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class FavoritesWorkerSpec: QuickSpec {
    override func spec() {
        describe("FavoritesWorker Spec") {
            
            let posterURL = "https://image.tmdb.org/t/p/w500/wwemzKWzjKYJFfCeiB57q3r4Bcm.png"
            var worker: FavoritesWorker!
            
            context("fetch image") {
                
                beforeEach {
                    worker = FavoritesWorker()
                }
                
                it("should fetch image") {
                    let imageView = worker.fetchPoster(posterPath: posterURL)
                    expect(imageView).toEventuallyNot(beNil())
                }
            }
        }
    }
}

