//
//  DesafioConcreteTests.swift
//  DesafioConcreteTests
//
//  Created by Matheus Henrique on 03/09/2018.
//  Copyright © 2018 Concrete.Matheus Henrique. All rights reserved.
//

import XCTest
@testable import DesafioConcrete

class DesafioConcreteTests: XCTestCase {
    
    //Variáveis
    var viewControllerGrid: UIViewController!
    
    //MARK: Fluxo de testes
    // Put setup code here. This method is called before the invocation of each test method in the class.
    override func setUp() {
        super.setUp()
        
        //Atribuição das views
        viewControllerGrid = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GridFilmesViewController")
        _ = viewControllerGrid.view        

    }//func setUp
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }  
    
}//Fim da classe
