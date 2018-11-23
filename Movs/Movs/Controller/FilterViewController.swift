//
//  FilterTableViewController.swift
//  Movs
//
//  Created by Erick Lozano Borges on 20/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController, MovieFilterDelegate {
    
    //MARK: - Properties
    var delegate: MovieFilterDelegate?
    var descriptions = ["Release Year", "Genre"]
    // Data
    var filter = Filter()
    var availableGenres = [Genre]()
    var availableReleaseYears = [String]()
    
    //MARK: - Interface
    lazy var tableFooterContentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = true
        return view
    }()
    
    lazy var applyFilterButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Apply Filter", for: .normal)
        button.setTitleColor(Design.colors.dark, for: .normal)
        button.backgroundColor = Design.colors.mainYellow
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Initializers
    init(delegate: MovieFilterDelegate, for movies: [Movie], style: UITableView.Style = .plain) {
        self.delegate = delegate
        super.init(style: style)
        getAvailableFilterParameters(from: movies)
        registerCells()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //MARK: - Setup
    func registerCells() {
        tableView.register(cellType: FilterTableViewCell.self)
    }
    
    func getAvailableFilterParameters(from movies: [Movie]) {
        movies.forEach { (movie) in
            
            if !availableReleaseYears.contains(movie.releaseYear) {
                availableReleaseYears.append(movie.releaseYear)
            }
            availableReleaseYears.sort(by: {$0 > $1})
            
            movie.genres.forEach({ (genre) in
                if !availableGenres.contains(where: {$0.id == genre.id}) {
                    availableGenres.append(genre)
                }
            })
            availableGenres.sort(by: {$0.name ?? "" < $1.name ?? ""})
        }
    }
    
    //MARK: - TableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptions.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FilterTableViewCell.self)
        switch indexPath.row {
        case 0:  cell.setup(description: descriptions[indexPath.row], selectedOption: filter.releaseYear)
        case 1:  cell.setup(description: descriptions[indexPath.row], selectedOption: filter.genre)
        default: cell.setup(description: "", selectedOption: nil)
        }
        return cell
    }
    
    //MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let filterParametersVC = FilterParameterTableViewController(delegate: self, forReleaseYears: availableReleaseYears)
            navigationController?.pushViewController(filterParametersVC, animated: true)
        case 1:
            let filterParametersVC = FilterParameterTableViewController(delegate: self, forGenres: availableGenres)
            navigationController?.pushViewController(filterParametersVC, animated: true)
        default: return
        }
    }
    
    //MARK: - Filter Handler
    @objc
    func applyFilter() {
        self.delegate?.filter.updateParameter(ofType: .genre, withValue: filter.genre)
        self.delegate?.filter.updateParameter(ofType: .releaseYear, withValue: filter.releaseYear)
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - CodeView
extension FilterTableViewController: CodeView {
    func buildViewHierarchy() {
        tableFooterContentView.addSubview(applyFilterButton)
        tableView.tableFooterView = tableFooterContentView
    
    }
    
    func setupConstraints() {
        let height = UIScreen.main.bounds.height - self.tableView.contentSize.height - 100
        tableFooterContentView.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
        
        applyFilterButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(30)
            make.height.equalTo(applyFilterButton.snp.width).multipliedBy(1.0/4.0)
        }
        
    }
    
    func setupAdditionalConfiguration() {
        tableView.tableFooterView?.layoutIfNeeded()
    }

}
