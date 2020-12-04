//
//  FavoritoTableViewController.swift
//  Movs
//
//  Created by Gabriel Coutinho on 03/12/20.
//

import Foundation
import UIKit
class FavoritosTabViewController: UIViewController {
    
    @IBOutlet weak var tabelaFilmes: UITableView!
    
    private var viewState: ViewState = .idle
    
    let buscarFilme: BuscarFilmeUseCase = BuscarFilme()
    let buscarImagem: BuscarImagemUseCase = BuscarImagem()
    let gerenciarFavoritos: GerenciarFavoritosUseCase = GerenciarFavoritos()
    let cellReuseIdentifier = "FavoritoCell"
    
    var filmesFavoritos: [Int] = []
        
    override func viewDidLoad() {
        tabelaFilmes.dataSource = self
        tabelaFilmes.delegate = self
        setViewLoading()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        atualizarFavoritos()
        tabelaFilmes.showAnimatedGradientSkeleton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilmeDetalhes",
           let filmeDetalhes = segue.destination as? FilmesDetalhesViewController,
           let row = tabelaFilmes.indexPathForSelectedRow?.row {
            let filme = filmesFavoritos[row]
            buscarFilme.por(id: filme) { media in
                filmeDetalhes.titulo = media?.title
                filmeDetalhes.fundoImagemPath = media?.backdropPath
                filmeDetalhes.descricao = media?.overview
                filmeDetalhes.generos = media?.genreList?.map({ $0.rawValue }) ?? []
                filmeDetalhes.lancamento = media?.releaseDate
                filmeDetalhes.estrelas = media?.voteAverage
            }
        }
    }
    
    func atualizarFavoritos() {
        DispatchQueue.main.async {
            guard let contexto = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
                fatalError("Unable to read managed object context.")
            }
            self.filmesFavoritos = self.gerenciarFavoritos.getFavoritos(em: contexto)
            self.tabelaFilmes.reloadData()
            self.setViewDone()
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
