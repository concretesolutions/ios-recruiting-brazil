//
//  FilterFavoriteViewControllerSpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 07/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import Movs

class FilterFavoriteViewControllerSpec: QuickSpec {
    override func spec() {
        var sut: FilterFavoriteViewController!
        var presenter: FilterFavoritePresentationMock!
        
        beforeEach {
            sut = UIStoryboard(name: "FilterFavorite", bundle: nil).instantiateViewController(withIdentifier: "FilterFavorite") as? FilterFavoriteViewController
            presenter = FilterFavoritePresentationMock()
            sut.presenter = presenter
            sut.view.didMoveToWindow()
        }
        
        describe("View") {
            it("Has to show filter favorite view", closure: {
                var movies: [MovieEntity] = []
                movies.append(MovieEntityMock.createMovieEntityInstance()!)
                sut.showAvaliableFilters(movies: movies)
                                
                expect(sut.view) == snapshot("FilterFavoriteView", usesDrawRect: false)
            })
            
            it("Has clicked apply filter") {
                sut.applyFilterButton.isEnabled = true
                sut.didClickApplyFilter(sut.applyFilterButton)
                guard let sutPresenter = sut.presenter as? FilterFavoritePresentationMock
                    else {
                        fail()
                        return
                }
                expect(sutPresenter.hasCalledDidEnterFilters).to(beTrue())
            }
        }
    }
}
