//
//  ListMovsFeatureTests.swift
//  ListMovsFeatureTests
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import XCTest
@testable import ListMovsFeature
import TestableMocks

class ListMovsFeatureTests: XCTestCase {

    var router: ListMovsRouter?
    
    override func setUp() {
        self.router = ListMovsRouter(isTestable: true)
    }

    override func tearDown() {
        self.router = nil
    }

    //Scenario: Loading of Presenter
    func test_load_init() {
        
        //Given: Loading Presenter with view
        router?.service = ListServiceMock(success: true)
        router?.favoriteCoreData = FavoriteMovCoreDataMock()
        let ui = router?.makeUI()
        
        //When Loading
        let presenter = router?.presenter
        presenter?.loading()
        
        //Then
        //Presenter deve conter 4 massas do fetch
        XCTAssertEqual(presenter?.viewDataModel.items.count, 5, "Devem ter os mesmos conteudos")
        
        // A mesma quantidade do presenter deve estar na UI
        XCTAssertEqual(presenter?.viewDataModel.items.count, ui?.viewData?.items.count, "Devem ter os mesmos conteudos")
        
        XCTAssertEqual(ui?.stateUI,
                       ListMovsHandleState.success(presenter!.viewDataModel),
                       "Deve tar com status de loading false")
    }
    
    //Scenario: Loading of Presenter with Fetch error
    func test_load_init_with_error() {
        
        //Given: Loading Presenter with view
        router?.service = ListServiceMock(success: false)
        router?.favoriteCoreData = FavoriteMovCoreDataMock()
        let ui = router?.makeUI()
        
        //When Loading
        let presenter = router?.presenter
        presenter?.loading()
        
        //Then :
        XCTAssertEqual(presenter?.viewDataModel.items.count, 0, "Deve ter zero de conteudos")
        XCTAssertNil(ui?.viewData, "Não deve conter viewDatas")
        XCTAssertEqual(ui?.stateUI, .failure, "Deve tar com status de error")
    }
    
    //Scenario: Select Mov for show more detail about one
    func test_select_mov() {
        //Given:
            //Loading Presenter with view
        router?.service = ListServiceMock(success: true)
        router?.favoriteCoreData = FavoriteMovCoreDataMock()
        let ui = router?.makeUI()
        
            //Information nextView
        var showDetail = false
        var showItemDetail: MovsItemViewData?
        let exp = expectation(description: "Showing detail view")
        router?.detailView = { item in
            showDetail = true
            showItemDetail = item
            exp.fulfill()
        }
        
        // When:
        // User select a movItem
        let item = MovsItemViewData.mockItem
        ui?.stateUI = ListMovsHandleState.showDetail(item)
        
        //Then:
        waitForExpectations(timeout: 3)
        XCTAssertEqual(showItemDetail?.id, item.id, "Devem ser os mesmos items")
        XCTAssertEqual(showItemDetail?.movieName, item.movieName, "Devem ser os mesmos items")
        XCTAssertEqual(showDetail, true, "Devem mostrar a proxima tela")
    }
    
    //Scenario: Choose a mov to yours favorite 
    func test_setup_favorite_item() {
        //Given:
        //Loading Presenter with view
        router?.service = ListServiceMock(success: true)
        router?.favoriteCoreData = FavoriteMovCoreDataMock()
        let ui = router?.makeUI()
        
        let presenter = router?.presenter
        presenter?.loading()
        
        //When:
        //Favorite an item        
        ui?.stateUI = .favoriteMovie(ui!.viewData!.items.first!)
        
        
        //Then:
        
        //use drop last 2 , pq o ultimo eh favorito por causa do mock
        XCTAssertTrue(presenter?.viewDataModel.items.first!.isFavorite ?? false,
                       "Item deve ser favorito")
        
        XCTAssertEqual(presenter?.viewDataModel.items.first!.id,
                       ui?.viewData?.items.first!.id,
                       "Item deve ser o mesmo da UI")
        
        
        
    }
    
    //Scenario: Remove a mov to yours favorite
    func test_remove_favorite_item() {
        //Given:
        //Loading Presenter with view
        router?.service = ListServiceMock(success: true)
        router?.favoriteCoreData = FavoriteMovCoreDataMock()
        let ui = router?.makeUI()
        
        let presenter = router?.presenter
        presenter?.loading()
        var item = ui?.viewData?.items[0] ?? MovsItemViewData.mockItem
        
        //When:
        //Remove favorite an item
        item.isFavorite = true
        ui?.stateUI = .favoriteMovie(item)
        
        
        //Then:
        XCTAssertTrue(presenter?.viewDataModel.items[0].isFavorite ?? true,
                       "Item deve ser favorito")
        
        XCTAssertEqual(presenter?.viewDataModel.items[0].id,
                       ui?.viewData?.items[0].id,
                       "Item deve ser o mesmo da UI")
        
        
        
    }
}
