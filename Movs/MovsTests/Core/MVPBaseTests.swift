//
//  MVPBaseTests.swift
//  MovsTests
//
//  Created by Gabriel Reynoso on 25/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import XCTest
@testable import Movs

class MVPBaseTests: XCTestCase {

    private lazy var baseViewController:MVPBaseViewController = {
        let vc = MVPBaseViewController()
        vc.basePresenter = self
        return vc
    }()
    
    private var methodWasCalled:Bool = false
    
    override func setUp() {
        self.methodWasCalled = false
    }
    
    func testBaseViewControllerShouldCallPresenterViewDidLoad() {
        self.baseViewController.viewDidLoad()
        XCTAssertTrue(self.methodWasCalled)
    }
    
    func testBaseViewControllerShouldCallPresenterViewWillAppear() {
        self.baseViewController.viewWillAppear(false)
        XCTAssertTrue(self.methodWasCalled)
    }
    
    func testBaseViewControllerShouldCallPresenterViewWillDisappear() {
        self.baseViewController.viewDidDisappear(false)
        XCTAssertTrue(self.methodWasCalled)
    }
    
    func testBaseViewControllerShouldCallPresenterViewDidDisappear() {
        self.baseViewController.viewWillDisappear(false)
        XCTAssertTrue(self.methodWasCalled)
    }
}

extension MVPBaseTests: PresenterProtocol {
    
    func viewDidLoad() {
        self.methodWasCalled = true
    }
    
    func viewWillAppear() {
        self.methodWasCalled = true
    }
    
    func viewWillDisappear() {
        self.methodWasCalled = true
    }
    
    func viewDidDisappear() {
        self.methodWasCalled = true
    }
}
