//
//  FilterSettingsViewController.swift
//  DesafioConcrete
//
//  Created by Ian Manor on 17/12/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import UIKit

class FilterSettingsViewController: UIViewController, UITableViewDelegate {
    
    var dateFilter: String?
    var genreFilter: String?

    var datePreviewLabel: UILabel?
    var genrePreviewLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true

        if let datePreviewLabel = datePreviewLabel {
            if let chosenDate = FilterSettings.shared.date {
                datePreviewLabel.isHidden = false
                datePreviewLabel.text = chosenDate
            } else {
                datePreviewLabel.isHidden = true
            }
        }

        if let genrePreviewLabel = genrePreviewLabel {
            if let chosenGenre = FilterSettings.shared.genre, let chosenGenreName = TMDBConfiguration.shared.genres?[chosenGenre] {
                genrePreviewLabel.isHidden = false
                genrePreviewLabel.text = chosenGenreName
            } else {
                genrePreviewLabel.isHidden = true
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "toDateFilters", sender: nil)
        } else {
            performSegue(withIdentifier: "toGenreFilters", sender: nil)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedSettingsTable" {
            let embeddedTableVC = segue.destination as! FilterSettingsTableViewController
            embeddedTableVC.tableView.delegate = self
    
            datePreviewLabel = embeddedTableVC.datePreview
            genrePreviewLabel = embeddedTableVC.genrePreview
        }
    }

    @IBAction func applyFilters(_ sender: Any) {
        FilterSettings.shared.isOn = true
        self.navigationController?.popViewController(animated: true)
    }
}
