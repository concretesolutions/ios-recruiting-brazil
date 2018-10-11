//
//  AlertFilterViewController.swift
//  DataMovie
//
//  Created by Andre Souza on 09/10/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

protocol AlertFiterActionProtocol {
    func didChangeFilter(value: Bool, _ userDefaultKey: MovieListFilters.BoolDefaultKey)
}

class AlertFilterViewController: UIViewController {
    
    @IBOutlet weak var filterSwitch: UISwitch!
    @IBOutlet weak var filterButton: UIButton!
    
    private var filterModel: AlertListMovieFilterModel?
    private var fiterActionProtocol: AlertFiterActionProtocol?
    private var filterAction: Selector?
    
    class func newInstance(with filterModel: AlertListMovieFilterModel, fiterActionProtocol: AlertFiterActionProtocol) -> AlertFilterViewController {
        let alertActionVC: AlertFilterViewController = AlertFilterViewController.fromNib()
        alertActionVC.filterModel = filterModel
        alertActionVC.fiterActionProtocol = fiterActionProtocol
        return alertActionVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    @IBAction func touchFilterButton(_ sender: Any) {
        filterSwitch.isOn = !filterSwitch.isOn
        didChangeFilter()
    }
    
}

extension AlertFilterViewController {
    
    private func setupViews() {
        filterButton.setTitle(filterModel?.buttonTitle, for: .normal)
        guard let userDefaultKey = filterModel?.userDefaultKey else { return }
        filterSwitch.isOn = UserDefaults.movieListFilters.bool(forKey: userDefaultKey)
    }
    
    private func didChangeFilter() {
        guard let userDefaultKey = filterModel?.userDefaultKey else { return }
        fiterActionProtocol?.didChangeFilter(value: filterSwitch.isOn, userDefaultKey)
    }
    
}
