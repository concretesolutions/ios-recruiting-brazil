//
//  FiltroEscolhaViewController.swift
//  ConcreteFilmes
//
//  Created by Luis Felipe Tapajos on 15/11/2020.
//  Copyright © 2020 Luis Felipe Tapajos. All rights reserved.
//

import UIKit

class FiltroEscolhaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView! = UITableView()
    
    var errorView = UIView()
    var filtroSelecionado = 0
    
    var filtroAnos : [String] = ["2016", "2017", "2018", "2019", "2020"]
    var filtroGeneros : [String] = ["Ação", "Comédia"]
    var filtros : [String] = []
    
    var filmeSelecionado: Filme? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        if (filtroSelecionado == 1) {
            //Carrega Filtro de Anos
            filtros = filtroAnos
        } else {
            //Carrega Filtro de Generos
            FilmesViewModel.shared.getGeneros(completionHandler: { results  in
                //print(results)
                
                if (results.count > 0) {
                    
                    //Remove View de Erro
                    self.errorView.removeFromSuperview()
                    
                    for i in 0 ..< results.count {
                        
                        FilmesViewModel.shared.getGenerosName(generoId: results[i] , completionHandler: { generoStr in
                            self.filtroGeneros.append(contentsOf: generoStr)
                            self.filtros =  self.filtroGeneros as [String]
                            self.tableView.reloadData()
                        })
                    }
                } else {
                    //Cria view de retorno com erro.
                    self.errorView = ErrorView.shared.loadView(view: self.view)
                    self.view.addSubview(self.errorView)
                    Help.shared.runThisAfterDelay(seconds: 3.0) {
                        self.errorView.removeFromSuperview()
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            })
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filtros.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let filtroCell = tableView.dequeueReusableCell(withIdentifier: "filtroEscolhaCell", for: indexPath)
        
        if (self.filtros[indexPath.row] == "2020") {
            filtroCell.accessoryType = .checkmark
        } else {
            filtroCell.accessoryType = .none
        }
        filtroCell.textLabel?.text = self.filtros[indexPath.row]
        
        return filtroCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
