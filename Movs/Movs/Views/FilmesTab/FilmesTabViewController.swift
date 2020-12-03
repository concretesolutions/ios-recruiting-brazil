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
        atualizarFavoritos()
        listarTendencia.getFilmesTendencia { trending in
            guard let movies = trending?.results else {
                self.setViewError()
                return
            }
            self.filmes = movies
            self.setViewDone()
        }
    }
    
    func atualizarFavoritos() {
        DispatchQueue.main.async {
            guard let contexto = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
                fatalError("Unable to read managed object context.")
            }
            self.filmesFavoritos = self.gerenciarFavoritos.getFavoritos(em: contexto)
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
