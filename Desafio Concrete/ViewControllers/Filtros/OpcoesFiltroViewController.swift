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
    
    @IBOutlet weak var tableView: UITableView!
    let variaveis = VariaveisOpcoesFiltro()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if variaveis.delegate != nil {
            variaveis.delegate?.voltarFiltro(date: variaveis.anoSelecionado, genre: variaveis.generoSelecionado)
        }
    }
    
    func setupTableView(){
        variaveis.dataSource = opcoesFiltroTableViewDataSource(elementos: variaveis.opcoes, filtroAno: variaveis.anoSelecionado, filtroGenero: variaveis.generoSelecionado)
        variaveis.filtroDelegate = opcoesFiltroTableViewDelegate(elementos: variaveis.opcoes, delegate: self)
        tableView.dataSource = variaveis.dataSource
        tableView.delegate = variaveis.filtroDelegate
        tableView.reloadData()
    }

}

extension OpcoesFiltroViewController: voltarFiltro {
    func voltarFiltro(date: Int?, genre: String?) {
        if let ano = date {
            variaveis.anoSelecionado = ano
        }
        
        if let genero = genre {
            variaveis.generoSelecionado = genero
        }
        
        setupTableView()
    }
}

extension OpcoesFiltroViewController: opcoesFiltroSelecionadoDelegate {
    func didSelect(indexPath: IndexPath) {
        let filtroSelecionadoViewController = self.storyboard?.instantiateViewController(withIdentifier: "FiltroSelecionadoViewController") as! FiltroSelecionadoViewController

        if indexPath.row.isZero() {
            filtroSelecionadoViewController.variaveis.tipoFiltro = "anos"
            if !(variaveis.anoSelecionado?.isZero() ?? true) { filtroSelecionadoViewController.variaveis.ano = variaveis.anoSelecionado }
        }else{
            filtroSelecionadoViewController.variaveis.tipoFiltro = "generos"
            if !(variaveis.generoSelecionado?.isEmpty ?? true) { filtroSelecionadoViewController.variaveis.genero = variaveis.generoSelecionado }
        }

        filtroSelecionadoViewController.variaveis.delegate = self

        self.navigationController?.pushViewController(filtroSelecionadoViewController, animated: true)
    }
}
