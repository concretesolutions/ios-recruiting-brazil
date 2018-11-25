//
//  FilterManagerScreen.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 23/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

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
            filteredYears = filteredYears.sorted{ $0 > $1 }
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
        
        applyFilterButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-30.0)
            make.leading.equalToSuperview().offset(30.0)
            make.trailing.equalToSuperview().offset(-30.0)
            make.height.equalTo(60.0)
        }
        
        yearFilterButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(30.0)
            make.leading.equalToSuperview().offset(60.0)
            make.trailing.equalToSuperview().offset(-60.0)
            make.height.equalTo(genreFilterButton)
        }
        
        genreFilterButton.snp.makeConstraints { make in
            make.top.equalTo(yearFilterButton.snp.bottom).offset(30.0)
            make.leading.equalToSuperview().offset(60.0)
            make.trailing.equalToSuperview().offset(-60.0)
            make.bottom.equalTo(applyFilterButton.snp.top).offset(-30.0)
        }
        
        yearFilterTitle.snp.makeConstraints { make in
            make.centerX.equalTo(yearFilterButton)
            make.leading.equalTo(yearFilterButton).offset(15)
            make.trailing.equalTo(yearFilterButton).offset(-15)
            make.centerY.equalTo(yearFilterButton).offset(-45)
        }
        
        genreFilterTitle.snp.makeConstraints { make in
            make.centerX.equalTo(genreFilterButton)
            make.leading.equalTo(genreFilterButton).offset(15)
            make.trailing.equalTo(genreFilterButton).offset(-15)
            make.centerY.equalTo(genreFilterButton).offset(-45)
        }
        
        yearFilterDescription.snp.makeConstraints { make in
            make.top.equalTo(yearFilterTitle.snp.bottom).offset(15)
            make.bottom.equalTo(yearFilterButton).offset(-15)
            make.leading.equalTo(yearFilterButton).offset(15)
            make.trailing.equalTo(yearFilterButton).offset(-15)
        }
        
        genreFilterDescription.snp.makeConstraints { make in
            make.top.equalTo(genreFilterTitle.snp.bottom).offset(15)
            make.bottom.equalTo(genreFilterButton).offset(-15)
            make.leading.equalTo(genreFilterButton).offset(15)
            make.trailing.equalTo(genreFilterButton).offset(-15)
        }
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
        
        filteredYears = filteredYears.sorted{ $0 > $1 }
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
