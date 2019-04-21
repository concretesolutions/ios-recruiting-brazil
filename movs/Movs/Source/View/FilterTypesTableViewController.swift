//
//  FilterViewController.swift
//  movs
//
//  Created by Lorien Moisyn on 20/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import UIKit
import RxSwift

class FilterTypesTableViewController: UITableViewController {
    
    var genreNames: [String] = []
    var years: [String] = []
    var goingForward = false
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        setButton()
    }
    
    func setButton() {
        let button = UIButton(frame: view.frame)
        tableView.tableFooterView = UIView(frame: view.frame)
        tableView.tableFooterView?.addSubview(button)
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(.darkBlue, for: .normal)
        button.backgroundColor = .mostard
        button.layer.cornerRadius = 10
        button.snp.makeConstraints { (make) in
            make.bottomMargin.equalToSuperview().offset(-230)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        button.rx
            .tap
            .asDriver()
            .drive(onNext: { _ in
                self.applyFilters()
            })
            .disposed(by: disposeBag)
    }
    
    func applyFilters() {
        guard let favoritesVC = navigationController?.children.first as? FavoritesViewController else { return }
        favoritesVC.presenter.combineFilters(genres: genreNames, years: years)
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        goingForward = true
        guard let genresVC = segue.destination as? GenresViewController else {
            guard let yearsVC = segue.destination as? YearsViewController else { return }
            yearsVC.selected = years
            return
        }
        genresVC.selected = genreNames
    }

}
