//
//  OpcoesFiltroViewController.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 28/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import UIKit

protocol voltarFiltro {
    func voltarFiltro(date: Int?, genre: String?)
}

class OpcoesFiltroViewController: UIViewController {

    let opcoes = ["Date", "Genre"]
    
    var anoSelecionado = 0
    var generoSelecionado = ""
    
    var delegate: voltarFiltro?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if delegate != nil {
            delegate?.voltarFiltro(date: anoSelecionado, genre: generoSelecionado)
        }
    }

}

extension OpcoesFiltroViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opcoes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = opcoes[indexPath.row]
        
        if generoSelecionado != "" && indexPath.row == 1 {
            cell.textLabel?.text = "Genero: \(generoSelecionado)"
        }
        
        if anoSelecionado != 0 && indexPath.row == 0 {
            cell.textLabel?.text = "Date: \(anoSelecionado)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let filtroSelecionadoViewController = self.storyboard?.instantiateViewController(withIdentifier: "FiltroSelecionadoViewController") as! FiltroSelecionadoViewController
        
        if indexPath.row == 0 {
            filtroSelecionadoViewController.tipoFiltro = "anos"
            if anoSelecionado != 0 { filtroSelecionadoViewController.ano = anoSelecionado }
        }else{
            filtroSelecionadoViewController.tipoFiltro = "generos"
            if generoSelecionado != "" { filtroSelecionadoViewController.genero = generoSelecionado }
        }
        
        filtroSelecionadoViewController.delegate = self
        
        self.navigationController?.pushViewController(filtroSelecionadoViewController, animated: true)
    }
    
}

extension OpcoesFiltroViewController: voltarFiltro {
    func voltarFiltro(date: Int?, genre: String?) {
        if let ano = date {
            anoSelecionado = ano
        }
        
        if let genero = genre {
            generoSelecionado = genero
        }
        
        print(anoSelecionado)
        print(generoSelecionado)
        
        tableView.reloadData()
    }
}
