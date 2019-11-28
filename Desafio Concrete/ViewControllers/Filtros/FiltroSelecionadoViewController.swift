//
//  FiltroSelecionadoViewController.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 28/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import UIKit

class FiltroSelecionadoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tipoFiltro: String = ""
    
    let anos = [2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019]
    
    var generos = [genres]()

    var delegate: voltarFiltro?
    
    var ano: Int? = nil
    var genero: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verificarFiltro()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if delegate != nil {
            delegate?.voltarFiltro(date: ano, genre: genero)
        }
    }
    
    func verificarFiltro(){
        if tipoFiltro == "generos" {
            FuncoesFilme().baixarGeneros { (result) in
                if let generos = result {
                    DispatchQueue.main.async {
                        self.generos = generos.genres ?? []
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

}

extension FiltroSelecionadoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tipoFiltro == "anos" {
            return anos.count
        }else{
            return generos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        if tipoFiltro == "anos" {
            if ano == anos[indexPath.row] {
                cell.accessoryType = .checkmark
            }
            cell.textLabel?.text = "\(anos[indexPath.row])"
        }else{
            if genero == generos[indexPath.row].name {
                cell.accessoryType = .checkmark
            }
            cell.textLabel?.text = "\(generos[indexPath.row].name ?? "")"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tipoFiltro == "anos" {
            ano = anos[indexPath.row]
        }else{
            genero = generos[indexPath.row].name ?? ""
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    
    }
    
    
}
