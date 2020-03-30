//
//  DetailMovsTests.swift
//  ListMovsFeatureTests
//
//  Created by Marcos Felipe Souza on 30/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import XCTest
@testable import ListMovsFeature

class DetailMovsTests: XCTestCase {
    
    var router: DetailItemMovsRouter?
    
    override func setUp() {
        self.router = DetailItemMovsRouter(isTestable: true)
    }

    override func tearDown() {
        self.router = nil
    }
    
    func test_apresentation_UI() {
        //Give: Setup Initial with Item.mock
        self.router?.genreService = GenresCoreDataMock()
        let ui = self.router?.makeUI(itemViewData: MovsItemViewData.mockItem)
        let presenter = router?.presenter
        //When: Show Up the viewDidLoad
        _ = ui?.view
        
        //Then:
        
        XCTAssertEqual(ui?.stateHandleUI,
                       DetailItemHandleState.loading(false),
                       "Cancela o Loading apos o sucesso")
        
        XCTAssertEqual(ui?.itemViewData?.id,
                       presenter?.itemViewData.id,
                       "Os items devem ser o mesmo")
        
        XCTAssertEqual(presenter?.itemViewData.genresString,
                       "Zero, One",
                       "Os generos devem ser separados por ',' e um 'espaço'")
        
    }
}
