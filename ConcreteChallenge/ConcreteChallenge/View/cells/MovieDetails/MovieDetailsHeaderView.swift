//
//  MovieDetailsHeaderView.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 25/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

class MovieDetailsHeaderView: UICollectionReusableView {
    var bluredView: UIVisualEffectView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var directorNameLabel: UILabel!
    @IBOutlet weak var directorJobLabel: UILabel!
    
    @IBOutlet weak var screenplayNameLabel: UILabel!
    @IBOutlet weak var screenplayJobLabel: UILabel!
    
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = true
        backgroundColor = .clear
        
        setupBackgroundImage()
        setupCoverImage()
    }
    
    func setup(with movieDetails: MovieDetails) {
        
        if let posterPath = movieDetails.posterPath {
            let url = URL(string: Constants.env.imageBaseUrl)?
                .appendingPathComponent("w500")
                .appendingPathComponent(posterPath)
            backgroundImageView.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "placeholder.png")
            )
            coverImageView.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "placeholder.png")
            )
        }
        
        genreLabel.text = movieDetails.genres
            .map({ $0.name })
            .joined(separator: ", ")
        
        let director = setupGroupedHeader(
            "Director",
            with: movieDetails.crew,
            nameLabel: directorNameLabel,
            jobLabel: directorJobLabel
        )
        
        _ = setupGroupedHeader(
            "Screenplay",
            with: movieDetails.crew,
            nameLabel: screenplayNameLabel,
            jobLabel: screenplayJobLabel,
            personException: director?.id
        )
        
        
        taglineLabel.text = movieDetails.tagline!.isEmpty ? movieDetails.overview : movieDetails.tagline
        
    }
    
    fileprivate func setupGroupedHeader(_ job: String, with crew: [Crew]?, nameLabel: UILabel, jobLabel: UILabel, personException: Int? = 0) -> Crew? {
        guard let crew = crew else { return nil }
                
        if let person = crew.first(where: { $0.job == job && personException != $0.id }) {
            nameLabel.text = person.name
            
            jobLabel.text = crew
                .filter({ $0.id == person.id })
                .map({ $0.job })
                .sorted()
                .joined(separator: ", ")
            
            return person
        }
        return nil
    }
    
    fileprivate func setupScreenplay(from crew: [Crew]?) {
        guard let crew = crew else { return }
                
        if let director = crew.first(where: { $0.job == "Director" }) {
            directorNameLabel.text = director.name
            
            directorJobLabel.text = crew
                .filter({ $0.id == director.id })
                .map({ $0.job })
                .joined(separator: ", ")
            
        }
    }
    
    fileprivate func setupCoverImage() {
        coverImageView.clipsToBounds = true
        coverImageView.layer.shadowPath =
            UIBezierPath(roundedRect: coverImageView.bounds,
                         cornerRadius: coverImageView.layer.cornerRadius).cgPath
        coverImageView.layer.shadowColor = UIColor.black.cgColor
        coverImageView.layer.shadowOpacity = 0.5
        coverImageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        coverImageView.layer.masksToBounds = false
        coverImageView.layer.shadowRadius = 10.0
    }
    
    fileprivate func setupBackgroundImage() {
        backgroundImageView.image = UIImage(named: "placeholder.png")
        backgroundImageView.fillSuperview()
        bluredView = backgroundImageView.blurred(style: .dark)
        bluredView.alpha = 0.9
    }
    
}
