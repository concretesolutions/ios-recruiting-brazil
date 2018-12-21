//
//  GenreTableViewController.swift
//  DesafioConcrete
//
//  Created by Ian Manor on 18/12/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import UIKit

class GenreTableViewController: UITableViewController {
    
    var genres: [(Int, String)] = []
    var previouslyChosen: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let genreList = TMDBConfiguration.shared.genres {
            for genre in genreList {
                genres.append((genre.key, genre.value))
            }
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let savedGenre = FilterSettings.shared.genre {
            for (offset, genre) in genres.enumerated() {
                if genre.0 == savedGenre {
                    previouslyChosen = IndexPath(row: offset, section: 0)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath) as! GenreTableViewCell

        // Configure the cell...
        cell.genreLabel.text = genres[indexPath.row].1
        
        if indexPath == previouslyChosen {
            cell.selectedImageView.isHidden = false
        } else {
            cell.selectedImageView.isHidden = true
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let previouslyChosen = previouslyChosen, let previouslySelectedCell = tableView.cellForRow(at: previouslyChosen) as? GenreTableViewCell {
            previouslySelectedCell.selectedImageView.isHidden = true
        }
        
        let currentlySelectedCell = tableView.cellForRow(at: indexPath) as! GenreTableViewCell
        currentlySelectedCell.selectedImageView.isHidden = false
    
        FilterSettings.shared.genre = genres[indexPath.row].0
        
        if previouslyChosen == indexPath {
            currentlySelectedCell.selectedImageView.isHidden = true
            FilterSettings.shared.genre = nil
            previouslyChosen = nil
        } else {
            previouslyChosen = indexPath
        }
        
    }

}
