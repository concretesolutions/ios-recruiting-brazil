//
//  FilterManagerScreen.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 23/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import UIKit

protocol FilterManagerDelegate: class{
    func setFilter(ofType: FilterType, with items:[String])
}

enum FilterType{
    case year
    case genre
}

final class FilterManagerScreen: UIView{
    
    var filteredYears:[String] = []{
        didSet{
            filteredYears = filteredYears.sorted{ $0 < $1 }
            update(label: yearFilterDescription, with: filteredYears)
        }
    }
    var filteredGenres:[String] = []{
        didSet{
            filteredGenres = filteredGenres.sorted()
            update(label: genreFilterDescription, with: filteredGenres)
        }
    }
    var delegate:FilterSelectionDelegate?
    
    lazy var yearFilterButton:UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var genreFilterButton:UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var applyFilterButton:UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var yearFilterTitle:UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var genreFilterTitle:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var yearFilterDescription:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var genreFilterDescription:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupView()
    }
    
    init(years:[String], genres:[String]){
        self.filteredYears = years
        self.filteredGenres = genres
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FilterManagerScreen: ViewCode{
    
    func setupViewHierarchy() {
        addSubview(yearFilterButton)
        addSubview(genreFilterButton)
        addSubview(applyFilterButton)
        addSubview(yearFilterTitle)
        addSubview(genreFilterTitle)
        addSubview(yearFilterDescription)
        addSubview(genreFilterDescription)
    }
    
    func setupConstraints() {
        applyFilterButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30.0).isActive = true
        applyFilterButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30.0).isActive = true
        applyFilterButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30.0).isActive = true
        applyFilterButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        yearFilterButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30.0).isActive = true
        yearFilterButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60.0).isActive = true
        yearFilterButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60.0).isActive = true
        yearFilterButton.heightAnchor.constraint(equalTo: genreFilterButton.heightAnchor).isActive = true
        
        genreFilterButton.topAnchor.constraint(equalTo: yearFilterButton.bottomAnchor, constant: 30.0).isActive = true
        genreFilterButton.bottomAnchor.constraint(equalTo: applyFilterButton.topAnchor, constant: -30).isActive = true
        genreFilterButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60.0).isActive = true
        genreFilterButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60.0).isActive = true
        genreFilterButton.heightAnchor.constraint(equalTo: yearFilterButton.heightAnchor).isActive = true
        
        yearFilterTitle.centerXAnchor.constraint(equalTo: yearFilterButton.centerXAnchor).isActive = true
        yearFilterTitle.leadingAnchor.constraint(equalTo: yearFilterButton.leadingAnchor, constant: 15.0).isActive = true
        yearFilterTitle.trailingAnchor.constraint(equalTo: yearFilterButton.trailingAnchor, constant: -15.0).isActive = true
        yearFilterTitle.centerYAnchor.constraint(equalTo: yearFilterButton.centerYAnchor, constant: -45.0).isActive = true
        
        genreFilterTitle.centerXAnchor.constraint(equalTo: genreFilterButton.centerXAnchor).isActive = true
        genreFilterTitle.leadingAnchor.constraint(equalTo: genreFilterButton.leadingAnchor, constant: 15.0).isActive = true
        genreFilterTitle.trailingAnchor.constraint(equalTo: genreFilterButton.trailingAnchor, constant: -15.0).isActive = true
        genreFilterTitle.centerYAnchor.constraint(equalTo: genreFilterButton.centerYAnchor, constant: -45.0).isActive = true
        
        yearFilterDescription.topAnchor.constraint(equalTo: yearFilterTitle.bottomAnchor, constant: 15.0).isActive = true
        yearFilterDescription.bottomAnchor.constraint(equalTo: yearFilterButton.bottomAnchor, constant: -15.0).isActive = true
        yearFilterDescription.leadingAnchor.constraint(equalTo: yearFilterButton.leadingAnchor, constant: 15.0).isActive = true
        yearFilterDescription.trailingAnchor.constraint(equalTo: yearFilterButton.trailingAnchor, constant: -15.0).isActive = true
        
        genreFilterDescription.topAnchor.constraint(equalTo: genreFilterTitle.bottomAnchor, constant: 15.0).isActive = true
        genreFilterDescription.bottomAnchor.constraint(equalTo: genreFilterButton.bottomAnchor, constant: -15.0).isActive = true
        genreFilterDescription.leadingAnchor.constraint(equalTo: genreFilterButton.leadingAnchor, constant: 15.0).isActive = true
        genreFilterDescription.trailingAnchor.constraint(equalTo: genreFilterButton.trailingAnchor, constant: -15.0).isActive = true
        
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = Palette.white
        
        setupButtons()
        setupLabels()
        
        yearFilterButton.addTarget(self, action: #selector(filterByYearTapped), for: .touchDown)
        genreFilterButton.addTarget(self, action: #selector(filterByGenreTapped), for: .touchDown)
        applyFilterButton.addTarget(self, action: #selector(applyFilterTapped), for: .touchDown)
        
        filteredGenres = filteredGenres.sorted()
        update(label: genreFilterDescription, with: filteredGenres)
        
        filteredYears = filteredYears.sorted{ $0 < $1 }
        update(label: yearFilterDescription, with: filteredYears)
        
    }
    
    func setupLabels(){
        yearFilterTitle.textColor = Palette.white
        yearFilterTitle.text = "By Year"
        yearFilterTitle.textAlignment = .center
        yearFilterTitle.font = UIFont(name: "Helvetica Neue", size: 30.0)
        
        genreFilterTitle.textColor = Palette.white
        genreFilterTitle.text = "By Genre"
        genreFilterTitle.textAlignment = .center
        genreFilterTitle.font = UIFont(name: "Helvetica Neue", size: 30.0)
        
        yearFilterDescription.textColor = Palette.white
        yearFilterDescription.textAlignment = .center
        yearFilterDescription.font = UIFont(name: "Helvetica Neue", size: 15.0)
        yearFilterDescription.numberOfLines = 3
        
        genreFilterDescription.textColor = Palette.white
        genreFilterDescription.textAlignment = .center
        genreFilterDescription.font = UIFont(name: "Helvetica Neue", size: 15.0)
        genreFilterDescription.numberOfLines = 3
    }
    
    func setupButtons(){
        yearFilterButton.backgroundColor = Palette.blue
        yearFilterButton.layer.cornerRadius = 12
        yearFilterButton.layer.borderWidth = 1
        yearFilterButton.layer.borderColor = Palette.blue.cgColor
        applyShadow(to: yearFilterButton)
        
        genreFilterButton.backgroundColor = Palette.blue
        genreFilterButton.layer.cornerRadius = 12
        genreFilterButton.layer.borderWidth = 1
        genreFilterButton.layer.borderColor = Palette.blue.cgColor
        applyShadow(to: genreFilterButton)
        
        applyFilterButton.backgroundColor = Palette.yellow
        applyFilterButton.setTitleColor(Palette.blue, for: .normal)
        applyFilterButton.layer.cornerRadius = 10
        applyShadow(to: applyFilterButton)
        applyFilterButton.setTitle("Apply Filter", for: .normal)
    }
    
    func applyShadow(to button:UIButton){
        button.layer.shadowColor = UIColor(red: 171, green: 186, blue: 186, alpha: 1.0).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.5)
        button.layer.shadowOpacity = 1.0
        button.layer.masksToBounds = false
    }
    
    func update(label: UILabel, with items:[String]){
        label.text = ""
        for elem in items{
            label.text?.append(contentsOf: "\(elem), ")
        }
        if items.count > 0{
            label.text?.removeLast(2)
        }
    }
    
}

extension FilterManagerScreen: FilterManagerDelegate{
    
    func setFilter(ofType type: FilterType, with items: [String]) {
        switch type{
        case .year:
            self.filteredYears = items
        case .genre:
            self.filteredGenres = items
        }
    }
}

extension FilterManagerScreen{
    
    @objc func filterByYearTapped(){
        CDMovieDAO.getPersistedYears { (years, error) in
            guard error == nil else {return}
            let filterVC = FilterViewController(items: years, type: .year, selectedItems: self.filteredYears)
            filterVC.delegate = self
            self.delegate?.didSelectFilter(for: filterVC)
        }
    }
    
    @objc func filterByGenreTapped(){
        CDMovieDAO.getPersistedGenres { (genres, error) in
            guard error == nil else {return}
            let filterVC = FilterViewController(items: genres, type: .genre, selectedItems: self.filteredGenres)
            filterVC.delegate = self
            self.delegate?.didSelectFilter(for: filterVC)
        }
    }
    
    @objc func applyFilterTapped(){
        delegate?.applyFilter(years: self.filteredYears, genres: self.filteredGenres)
    }
}
