//
//  GenreFilterController.swift
//  Movs
//
//  Created by Victor Rodrigues on 18/11/18.
//  Copyright © 2018 Victor Rodrigues. All rights reserved.
//

import UIKit

class GenreFilterController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

}

//MARK: Functions
extension GenreFilterController {
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

//MARK: TableView
extension GenreFilterController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayGenres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let genre = arrayGenres[indexPath.row]
        cell.textLabel?.text = genre
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let genre = arrayGenres[indexPath.row]
        
        if genre == "Empty" {
            defaults.set("", forKey: keyGenre)
        } else {
            defaults.set(genre, forKey: keyGenre)
        }
        
        defaults.synchronize()
        
        navigationController?.popViewController(animated: true)
    }
    
}
