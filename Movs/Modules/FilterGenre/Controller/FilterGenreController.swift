//
//  FilterGenreController.swift
//  Movs
//
//  Created by Joao Lucas on 15/10/20.
//

import UIKit

protocol FilterByGenreDelegate: class {
    func getGenreSelected(genre: String)
}

class FilterGenreController: UITableViewController {
    
    private var genresList = ["Action", "Horror"]
    
    weak var delegate: FilterByGenreDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genresList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let genre = genresList[indexPath.row]
        
        cell.textLabel?.text = genre

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let genre = genresList[indexPath.row]
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        delegate.getGenreSelected(genre: genre)
        navigationController?.popViewController(animated: true)
    }
}
