//
//  DateFilterPresenter.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

class DateFilterPresenter: DateFilterPresentation, DateFilterInteractorOutput {
    
    // MARK: - Properties
    var view: DateFilterView?
    var interactor: DateFilterInteractorInput!
    var router: DateFilterWireframe!
    
    var datesFilter: [Date] = []
    
    // MARK: - DateFilterPresentation functions
    func viewDidLoad() {
        self.interactor.getDates()
    }
    
    func didSelectDate(date: Date) {
        datesFilter.append(date)
    }
    
    func didDeselectDate(date: Date) {
        datesFilter.removeAll { (dateFromArray) -> Bool in
            dateFromArray.year == date.year
        }
    }
    
    func didTapSaveButton() {
        self.router.exitWithDateFilter(dates: datesFilter)
    }
    
    // MARK: - DateFilterInteractorOutput functions
    func didGetDates(dates: [Date]) {
        self.view?.showDates(dates: dates)
    }
}
