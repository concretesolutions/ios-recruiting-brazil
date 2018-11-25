//
//  FilterChoosePresenter.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 25/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit
import CoreData

class FilterChoosePresenter: NSObject {
    // MARK: - Properties
    // MARK: - Outlets
    // MARK: Public
    var router:FilterChooseRouter
    var interactor:FilterChooseInteractor
    var view:FilterChooseView
    
    // MARK: - Initializers
    init(router:FilterChooseRouter, interactor:FilterChooseInteractor, view:FilterChooseView) {
        self.router = router
        self.interactor = interactor
        self.view = view
        super.init()
        self.view.presenter = self
        
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func viewDidLoad() {
        self.view.outletTableView.dataSource = self
    }
    
    func cellDidSelected(_ tableView: UITableView, withCell cell: FilterChooseTableViewCell, andIndexPath indexPath: IndexPath){
        
        if let checkIndexPathRow = self.interactor.checkedRow{
            if checkIndexPathRow == indexPath.row{
                self.interactor.checkedRow = nil
            }else{
                let oldCell = tableView.cellForRow(at: IndexPath(row: checkIndexPathRow, section: 0)) as! FilterChooseTableViewCell
                oldCell.isChecked = !oldCell.isChecked
                oldCell.setImage()
                self.interactor.checkedRow = indexPath.row
            }
        }else{
            self.interactor.checkedRow = indexPath.row
        }
        
        cell.isChecked = !cell.isChecked
        cell.setImage()
    }
    
    func getDataChecked() -> NSManagedObject?{
        return self.interactor.getDataChecked()
    }
    
    func willDismiss(toFilterView filterView: FilterView){
        if self.interactor.cellType == .genre{
            if let genre = getDataChecked(){
                filterView.presenter.interactor.genre = genre as? Gener
            }else{
                filterView.presenter.interactor.genre = nil
            }
        }else{
            if let film = getDataChecked(){
                if let releaseYear = (film as! Film).release_date?.split(separator: "-").first {
                    filterView.presenter.interactor.year = String(releaseYear)
                }
            }else{
                filterView.presenter.interactor.year = nil
            }
        }
    }
}

extension FilterChoosePresenter: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor.infos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.interactor.cellType == .genre{
            let cell: FilterChooseTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            var state: Bool = false
            if let checkedRow = self.interactor.checkedRow{
                if checkedRow == indexPath.row{
                    state = true
                }
            }
            cell.setup(name: (self.interactor.infos as! [Gener])[indexPath.row].name, andCheckState: state)
            return cell
        }else{
            let cell: FilterChooseTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            let film = (self.interactor.infos as! [Film])[indexPath.row]
            var state: Bool = false
            if let checkedRow = self.interactor.checkedRow{
                if checkedRow == indexPath.row{
                    state = true
                }
            }
            if let releaseYear = film.release_date?.split(separator: "-").first {
                cell.setup(name: String(releaseYear), andCheckState: state)
            }else{
                cell.setup(name: film.release_date, andCheckState: state)
            }
            return cell
        }
    }
    
    
}

