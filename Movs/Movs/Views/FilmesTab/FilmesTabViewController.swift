//
//  FilmesTabViewController.swift
//  Movs
//
//  Created by Gabriel Coutinho on 01/12/20.
//

import Foundation
import UIKit

import SkeletonView

class FilmesTabViewController: UIViewController {
    
    @IBOutlet weak var tabelaFilmes: UITableView!
    
    private var viewState: ViewState = .idle
    
    let listarTendencia: ListarFilmesTendenciaUseCase = ListarFilmesTendencia()
    let gerenciarFavoritos: GerenciarFavoritosUseCase = GerenciarFavoritos()
    let cellReuseIdentifier = "FilmeCell"
    
    var filmes: [Media] = []
    var filmesFavoritos: [Int] = []
        
    override func viewDidLoad() {
        tabelaFilmes.dataSource = self
        tabelaFilmes.delegate = self
        setViewLoading()
        listarTendencia.getFilmesTendencia { trending in
            guard let movies = trending?.results else {
                self.setViewError()
                return
            }
            self.filmes = movies
            self.setViewDone()
        }
    }
    
    private func setViewLoading() {
        viewState = .loading
        tabelaFilmes.showAnimatedGradientSkeleton()
    }
    
    private func setViewDone() {
        viewState = .done
        tabelaFilmes.hideSkeleton()
        tabelaFilmes.reloadData()
    }
    
    private func setViewError() {
        viewState = .error
        tabelaFilmes.hideSkeleton()
    }
}
