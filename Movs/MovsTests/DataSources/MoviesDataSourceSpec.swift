//
//  MoviesDataSourceSpec.swift
//  MovsTests
//
//  Created by Brendoon Ryos on 07/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class CollectionViewDelegateMock: NSObject, UICollectionViewDelegate {
  
}

class MoviesDataSourceSpec: QuickSpec {
  override func spec() {
    describe("a MoviesDataSource ") {
      var dataSource: MoviesDataSource!
      var movie: Movie!
      var collectionView: UICollectionView!
      
      beforeEach {
        let sampleData = MovsAPI.fetchPopularMovies(page: 1).sampleData
        let moviesData = try? JSONDecoder().decode(MoviesData.self, from: sampleData)
        movie = moviesData?.results.first
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 500), collectionViewLayout: UICollectionViewFlowLayout())
        dataSource = MoviesDataSource(collectionView: collectionView, delegate: CollectionViewDelegateMock())
        dataSource.updateItems([movie])
      }
      
      it("should have a valid dataSource") {
        expect(dataSource).toNot(beNil())
      }
      
      it("should have the expected number of items") {
        let count = dataSource.collectionView(collectionView, numberOfItemsInSection: 0)
        expect(count).to(equal(1))
      }
      
      it("should have be able to update items") {
        dataSource.updateItems([movie, movie, movie])
        let count = dataSource.collectionView(collectionView, numberOfItemsInSection: 0)
        expect(count).to(equal(4))
      }
      
      it("should return the expected cell") {
        let cell = dataSource.collectionView(collectionView, cellForItemAt: IndexPath(row: 0, section: 0))
        expect(cell).to(beAKindOf(MovieCollectionViewCell.self))
      }
    }
  }
}

