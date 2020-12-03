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
    
    var pagina: Int = 1
    var linhaLimite: Int = 0
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
            self.pagina += 1
            self.setViewDone()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilmeDetalhes",
           let filmeDetalhes = segue.destination as? FilmesDetalhesViewController,
           let row = tabelaFilmes.indexPathForSelectedRow?.row {
            let filme = filmes[row]
            filmeDetalhes.titulo = filme.title
            filmeDetalhes.fundoImagemPath = filme.backdropPath
            filmeDetalhes.descricao = filme.overview
            filmeDetalhes.generos = filme.genreList?.map({ $0.rawValue }).joined(separator: "; ")
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
    
    func setViewLoading() {
        viewState = .loading
        tabelaFilmes.showAnimatedGradientSkeleton()
    }
    
    func setViewDone() {
        viewState = .done
        tabelaFilmes.hideSkeleton()
        tabelaFilmes.reloadData()
    }
    
    func setViewError() {
        viewState = .error
        tabelaFilmes.hideSkeleton()
    }
}
