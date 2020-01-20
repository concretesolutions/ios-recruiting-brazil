//
//  FilterViewController.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 20/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate: class {
    func applyFilter(for date: String, genreID: Int)
}

class FilterViewController: UIViewController {
    
    let genreCollection: GenreCollection
    var filter: [(key: String, value: String)] = [("Date", ""), ("Genre", "")]
    
    let dateOptions = ["2015", "2016", "2017", "2018", "2019", "2020"]
    var isChoosingDate = true
    
    weak var delegate: FilterViewControllerDelegate?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        
        return tableView
    }()
    
    lazy var applyButton: UIButton = {
        let applyButton = UIButton(type: .system)
        
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.setTitle("Apply", for: .normal)
        applyButton.backgroundColor = .gray
        applyButton.layer.cornerCurve = .continuous
        applyButton.layer.cornerRadius = 24
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.titleLabel?.font =  UIFont.systemFont(ofSize: 18, weight: .regular)
        applyButton.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        applyButton.isEnabled = false
        
        return applyButton
    }()
    
    init(genreCollection: GenreCollection) {
        self.genreCollection = genreCollection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(applyButton)
    }
    
    func setupConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: applyButton.topAnchor, constant: -16).isActive = true
        
        applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        applyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        applyButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    @objc func applyFilter() {
        let date = filter[0].value
        let genreType = filter[1].value
        let genreID = genreCollection.getId(for: genreType)
        
        delegate?.applyFilter(for: date, genreID: genreID)
        dismiss(animated: true, completion: nil)
    }
    
}

extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = filter[indexPath.row].key
        cell.detailTextLabel?.text = filter[indexPath.row].value
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isChoosingDate = true
        
        var filterDetailViewController = FilterDetailViewController(data: dateOptions)
        
        if indexPath.row == 1 {
            filterDetailViewController = FilterDetailViewController(data: genreCollection.getAllGenresTypes())
            isChoosingDate = false
        }
        
        filterDetailViewController.delegate = self
        navigationController?.pushViewController(filterDetailViewController, animated: true)
    }
}

extension FilterViewController: FilterDetailViewControllerDelegate {
    func record(data: String) {
        if isChoosingDate {
            filter[0].value = data
        } else {
            filter[1].value = data
        }
        
        if filter[0].value != "" && filter[1].value != "" {
            applyButton.isEnabled = true
            applyButton.backgroundColor = .black
        }
        
        tableView.reloadData()
    }
}
