//
//  DateFilter.swift
//  Movs
//
//  Created by Victor Rodrigues on 18/11/18.
//  Copyright © 2018 Victor Rodrigues. All rights reserved.
//

import UIKit

class DateFilterController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    var selectedDate = [String]()
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(selectedDate)
    }
    
}

//MARK: Functions
extension DateFilterController {
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

//MARK: TableView
extension DateFilterController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let date = arrayDates[indexPath.row]
        cell.textLabel?.text = date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let date = arrayDates[indexPath.row]
        
        if date == "Empty" {
            defaults.set("", forKey: keyDate)
        } else {
            defaults.set(date, forKey: keyDate)
        }
        
        defaults.synchronize()
        
        navigationController?.popViewController(animated: true)
    }
    
}
