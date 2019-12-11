//
//  MovieDetailScreenSpec.swift
//  MovsCodeViewTests
//
//  Created by Carolina Cruz Agra Lopes on 10/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit
import Quick
import Nimble
import Nimble_Snapshots
@testable import Movs

class MovieDetailScreenSpec: QuickSpec {

    // MARK: - Sut

    private var sut: MovieDetailScreen!

    // MARK: - Tests

    override func spec() {
        describe("MovieDetailScreen") {
            beforeEach {
                self.sut = MovieDetailScreen(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))

                let mockFetcher = MockDataFetcher()
                mockFetcher.mockData()

                DataProvider.shared.reset()
                DataProvider.shared.setup(withDataFetcher: mockFetcher) { _ in }

                self.sut.configure(with: Movie(fromDTO: mockFetcher.movies[2]![0], smallImageURL: nil, bigImageURL: nil, isFavourite: false))
            }

            afterEach {
                self.sut = nil
            }

            it("should have the expected look and feel") {
                waitUntil { done in
                    DispatchQueue.global().asyncAfter(deadline: .now() + 0.0001) {
                        DispatchQueue.main.async {
                            expect(self.sut) == snapshot("MovieDetailScreen")
                            done()
                        }
                    }
                }
            }
        }
    }
}
