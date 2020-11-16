//
//  FiltrosViewController.swift
//  ConcreteFilmes
//
//  Created by Luis Felipe Tapajos on 15/11/2020.
//  Copyright © 2020 Luis Felipe Tapajos. All rights reserved.
//

import UIKit

class FiltrosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView! = UITableView()
    var filtros = ["Anos", "Generos"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.dataSource = self
        self.tableView.delegate = self
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func botaoVoltar(_ sender: UIButton) {
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtros.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let filtroCell = tableView.dequeueReusableCell(withIdentifier: "filtroCell", for: indexPath)
        filtroCell.textLabel?.text = filtros[indexPath.row]
        
        return filtroCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //tableView.deselectRow(at: indexPath, animated: true)
        var tipoSelecionado = 0
        
        if (filtros[indexPath.row] == "Anos") {
            tipoSelecionado = 1
        } else {
            tipoSelecionado = 2
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FiltroEscolha") as! FiltroEscolhaViewController
        
        //viewController.customInit(mainMenuIndex: indexPath.row, title: filtros[indexPath.row])
        controller.filtroSelecionado = tipoSelecionado
        self.navigationController?.pushViewController(controller, animated: true)
        
        //tableView.deselectRow(at: indexPath, animated: true)
        //print(filtros[indexPath.row])
        
    }
    
    @IBAction func aplicarFiltrosVoltar(_ sender: UIButton) {
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }

}
