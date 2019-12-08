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
    let variaveis = VariaveisFiltroSelecionado()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verificarFiltro()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if variaveis.delegate != nil {
            variaveis.delegate?.voltarFiltro(date: variaveis.ano, genre: variaveis.genero)
        }
    }
    
    func setupTableViewDelegates(){
        if variaveis.tipoFiltro == "generos"{
            variaveis.filtroDataSource = filtroTableViewDataSource(elementos: variaveis.generos)
            variaveis.filtroDelegate = filtroTableViewDelegate(elementos: variaveis.generos,tipoFiltro: .genero, delegate: self)
        }else{
            variaveis.filtroDataSource = filtroTableViewDataSource(elementos: variaveis.anos)
            variaveis.filtroDelegate = filtroTableViewDelegate(elementos: variaveis.anos, tipoFiltro: .ano, delegate: self)
        }
        tableView.dataSource = variaveis.filtroDataSource
        tableView.delegate = variaveis.filtroDelegate
        tableView.reloadData()
    }
    
    func setupArrayAnos(){
        for ano in 2000...variaveis.anoAtual {
            variaveis.anos.append(ano)
        }
    }
    
    func verificarFiltro(){
        if variaveis.tipoFiltro == "generos" {
            RequestAPI().baixarGeneros { (result) in
                if let generos = result {
                    DispatchQueue.main.async {
                        let genResult = generos.genres ?? []
                        let _ = genResult.map { (result) in
                            self.variaveis.generos.append(result.name ?? "")
                            self.setupTableViewDelegates()
                        }
                    }
                }
            }
        }else{
            setupArrayAnos()
            setupTableViewDelegates()
        }
    }

}

extension FiltroSelecionadoViewController: filtroSelecionadoDelegate {
    func didSelect(filtro: Any, tipoFiltro: TipoFiltroSelecionado) {
        if tipoFiltro == .genero {
            self.variaveis.genero = filtro as? String
        }else{
            self.variaveis.ano = filtro as? Int
        }
    }
}


