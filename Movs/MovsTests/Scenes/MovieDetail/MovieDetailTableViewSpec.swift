//
//  MovieDetailTableViewSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class MovieDetailTableViewSpec: QuickSpec {
    override func spec() {
        describe("MovieDetailTableView Spec") {
            
            context("init with coder") {
                it("should raise exception") {
                    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                    expect(MovieDetailTableView(coder: archiver)).to(raiseException())
                }
            }
            
            context("data source and delegate") {
                var tableView: MovieDetailTableView!
                
                beforeEach {
                    tableView = MovieDetailTableView(style: .plain)
                }
                
                it("should have 1 section") {
                    expect(tableView.dataSource?.numberOfSections!(in: tableView)).to(equal(1))
                }
                
                it("should have 3 rows in section") {
                    let rows = tableView.dataSource?.tableView(tableView,
                                                               numberOfRowsInSection: 0)
                    expect(rows).to(equal(3))
                }
                
                it("should return titleCell") {
                    let cell = tableView.tableView(tableView,
                                                   cellForRowAt: IndexPath(row: 0,
                                                                           section: 0))
                    expect(tableView.titleCell).to(equal(cell))
                }
                
                it("should return yearCell") {
                    let cell = tableView.tableView(tableView,
                                                   cellForRowAt: IndexPath(row: 1,
                                                                           section: 0))
                    expect(tableView.yearCell).to(equal(cell))
                }
                
                it("should return genreCell") {
                    let cell = tableView.tableView(tableView,
                                                   cellForRowAt: IndexPath(row: 2,
                                                                           section: 0))
                    expect(tableView.genreCell).to(equal(cell))
                }
                
                it("should return empty cell") {
                    let cell = tableView.tableView(tableView,
                                                   cellForRowAt: IndexPath(row: 4,
                                                                           section: 0))
                    expect(tableView.titleCell).toNot(equal(cell))
                    expect(tableView.yearCell).toNot(equal(cell))
                    expect(tableView.genreCell).toNot(equal(cell))
                }
                
            }
        }
    }
}

