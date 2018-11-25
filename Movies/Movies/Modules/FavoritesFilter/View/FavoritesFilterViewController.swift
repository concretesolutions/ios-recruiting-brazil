//
//  FavoritesFilterViewController.swift
//  Movies
//
//  Created by Renan Germano on 25/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class FavoritesFilterViewController: UIViewController, FavoritesFilterView {
    
    // MARK: - Properties
    
    var presenter: FavoritesFilterPresentation!
    private var genresSection: UIView!
    private var genres: ButtonsSet!
    private var genresDelegate: GenresButtonsSetDelegate!
    
    private var yearsSection: UIView!
    private var years: ButtonsSet!
    private var yearsDelegate: YearsButtonsSetDelegate!

    // MARK: - Life cicle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewDidLoad()
    }
    
    // MARK: - Aux functions
    
    private func createSection(withTitle title: String) -> UIView {
        
        let view = UIView(frame: .zero)
        let label = UILabel(frame: .zero)
        
        label.text = title
        label.textAlignment = .left
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }
    
    private func setUpGenresSection() {
        self.genresSection = self.createSection(withTitle: "Select the Genres")
        self.genresSection.backgroundColor = .lightGray
        
        self.genresSection.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.genresSection)
        self.genresSection.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.genresSection.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.genresSection.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.genresSection.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    private func setUpYearsSection() {
        self.yearsSection = self.createSection(withTitle: "Select the Years")
        self.yearsSection.backgroundColor = .lightGray
        
        self.yearsSection.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.yearsSection)
        self.yearsSection.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.yearsSection.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.yearsSection.topAnchor.constraint(equalTo: self.genres.bottomAnchor).isActive = true
        self.yearsSection.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    // MARK: - FilterView protocol functions
    
    func set(genres: [(genre: Genre, isSelected: Bool)]) {
        self.setUpGenresSection()
        
        let titles = genres.map { return $0.genre.name }
        let states = genres.map { return $0.isSelected }
        
        let normalStyle = ButtonsSet.Style(titleColor: .black, titleBold: true, backgroundColor: .white, borderWidth: 3, borderColor: .black, cornerRadius: 10)
        let highlightedStyle = ButtonsSet.Style(titleColor: .white, titleBold: true, backgroundColor: .black, borderWidth: 3, borderColor: .black, cornerRadius: 10)
        
        self.genres = ButtonsSet(width: Float(self.view.frame.width-14), buttonHeight: 30, spacing: 7, buttonNames: Set(titles), order: .AlphabeticAsc, buttonNormalStyle: normalStyle, buttonHighlitedStyle: highlightedStyle, buttonBehavior: .Select)
        self.genres.buttonsSelectedStates = states
        
        self.genres.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.genres)
        self.genres.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 7).isActive = true
        self.genres.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -7).isActive = true
        self.genres.topAnchor.constraint(equalTo: self.genresSection.bottomAnchor, constant: 8).isActive = true
        
        self.genresDelegate = GenresButtonsSetDelegate(presenter: self.presenter, genres: genres.map { return $0.genre })
        self.genres.delegate = self.genresDelegate
    }
    
    func set(years: [(year: Int, isSelected: Bool)]) {
        self.setUpYearsSection()
        
        let titles = years.map { return String($0.year) }
        let states = years.map { return $0.isSelected }
        
        let normalStyle = ButtonsSet.Style(titleColor: .black, titleBold: true, backgroundColor: .white, borderWidth: 3, borderColor: .black, cornerRadius: 10)
        let highlightedStyle = ButtonsSet.Style(titleColor: .white, titleBold: true, backgroundColor: .black, borderWidth: 3, borderColor: .black, cornerRadius: 10)
        
        self.years = ButtonsSet(width: Float(self.view.frame.width-14), buttonHeight: 30, spacing: 7, buttonNames: Set(titles), order: .AlphabeticAsc, buttonNormalStyle: normalStyle, buttonHighlitedStyle: highlightedStyle, buttonBehavior: .Select)
        self.years.buttonsSelectedStates = states
        
        self.years.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.years)
        self.years.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 7).isActive = true
        self.years.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -7).isActive = true
        self.years.topAnchor.constraint(equalTo: self.yearsSection.bottomAnchor, constant: 8).isActive = true
        
        self.yearsDelegate = YearsButtonsSetDelegate(presenter: self.presenter)
        self.years.delegate = self.yearsDelegate
    }

}
