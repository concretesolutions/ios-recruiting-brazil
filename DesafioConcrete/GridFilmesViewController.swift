//
//  GridFilmesViewController.swift
//  DesafioConcrete
//
//  Created by Matheus Henrique on 06/09/2018.
//  Copyright © 2018 Concrete.Matheus Henrique. All rights reserved.
//

import UIKit
import SDWebImage//Carrega foto a partir da URL
import TMDBSwift//Interface com TMDB
import Firebase//Persistência de dados e cadastro de usuário

class CelulaCollection: UICollectionViewCell{
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var buttonFavoritar: UIButton!
}//Fim da classe CelulaCollection

//MARK: ENUM Estado Collection
enum EstadoCollection{
    case carregando
    case concluido([Filme])
    case retornoBusca([Int])
    case semResultado
    case erro
    
    var dadosFilme : [Filme]{
        switch self  {
        case .concluido(let filmes):
            return filmes
        default:
            return []
        }//switch self
    }//var dadosFilme: [Filme]
    
    var indicesBusca : [Int]{
        switch self  {
        case .retornoBusca(let indiceFilme):
            return indiceFilme
        default:
            return []
        }//switch self
    }//var indicesBusca: [Int]
}//enum EstadoTabela

class GridFilmesViewController: UIViewController {
    
    //MARK: Objetos de Interface
    @IBOutlet weak var collectionFilmes: UICollectionView!//Grid
    @IBOutlet weak var barraPesquisa: UISearchBar!
    //Views retorno usuário
    @IBOutlet var viewRetornoBusca: UIView!
    @IBOutlet var viewErro: UIView!
    @IBOutlet var viewCarregando: UIView! 
    @IBOutlet weak var labelRetornoBusca: UILabel!
    
    //MARK: Variáveis
    var referenciaRealtime: DatabaseReference!
    let idUsuarioAtual = Auth.auth().currentUser?.uid
    var arrayIndexPathFavoritos: [IndexPath]! = []//Armazena os botões que foram selecionados como favoritos
    var arrayIDFavoritos: [Int]! = []
    var itemSelecionado = 0 //Índice do item selecionado no Grid de filmes
    var modoPesquisa = false //Informa para a interface se o usuário iniciou uma pesquisa
    var pagina = 1 //Incrementada de acordo com o que o usuário rola a tela, para fazer o infinito
    var favorito = false//Informa a view de detalhes se o filme já é um favorito
    var filmesEncontrados: [Filme] = []
    
    //MARK: Handle do Enum DadosCollection
    //Inicializa como "carregando"
    var estadoCollection = EstadoCollection.carregando {
        didSet {
            setaRetornoUsuario()
            collectionFilmes.reloadData()
        }//didSet
    }// var estadoTabela = DadosTabela.carregando
    
    func setaRetornoUsuario() {
        switch estadoCollection{
        case .carregando:
            collectionFilmes.backgroundView = viewCarregando
        case .concluido:
            collectionFilmes.backgroundView = nil
        case .retornoBusca:
            collectionFilmes.backgroundView = nil
        case .semResultado:
            collectionFilmes.backgroundView = viewRetornoBusca
        case .erro:
            collectionFilmes.backgroundView = viewErro
        }//switch estadoTabela
    }//func setFooterView()
    
    //MARK: Ciclo da View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Para quando retorna da tela de detalhes
        favorito = false
    }//func viewWillAppear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Inicializa referências e delegates
        referenciaRealtime = Database.database().reference()
        barraPesquisa.delegate = self
        barraPesquisa.returnKeyType = .done //Para fechar o teclado quando deixar o campo de pesquisa em branco
        barraPesquisa.autocapitalizationType = .none
        barraPesquisa.autocorrectionType = .no
        
        //Configura a chave da API TMDB
        TMDBConfig.apikey = "43714bc5fc5ede94598f5a2f2061a426"
        
        estadoCollection = .carregando
        
        //Busca favoritos e filmes
        buscaFavoritos()
    }//func viewDidLoad()
    
    
    //MARK: Busca dados
    func buscaFavoritos(){
        //Busca no Firebase
        referenciaRealtime.child("\(idUsuarioAtual ?? "nulo")/favoritos").observe(.value, with: { (snapshot) in
            self.arrayIDFavoritos.removeAll()//Remove resultados anteriores
            self.arrayIndexPathFavoritos.removeAll()
            
            for filme in snapshot.children.allObjects as! [DataSnapshot] {
                //Verifica se há favoritos
                if let idFilme = filme.value as? Int{
                    self.arrayIDFavoritos.append(idFilme)
                }//if let idFilme = filme.value
            }// for filme in snapshot.children.allObjects as! [DataSnapshot]
            //Busca filmes
            self.buscaPopulares()
        }){ (error) in
            self.estadoCollection = .erro
            print(error.localizedDescription)//Retorno para o console
        }//error
    }//func buscaFavoritos
    
    func buscaPopulares(){
        MovieMDB.popular(language: "pt-BR", page: pagina, completion: {dados, filmesPopulares in
            if let filmesArray = filmesPopulares{//Há valor
                for i in 0..<filmesPopulares!.count{                    
                    //Substring para o ano de lançamento
                    let ano = String((filmesArray[i].release_date?.prefix(4))!)
                    
                    //Cria objeto filme
                    let objFilme = Filme(id: filmesArray[i].id, nome: filmesArray[i].title,ano: ano, caminhoImagem: filmesArray[i].poster_path)
                    
                    self.filmesEncontrados.append(objFilme)
                }//for i in 0..<filmesPopulares!
            }//if let filmesArray = filmesPopulares
            //Se não foi possível carregar, demonstra erro
            if self.filmesEncontrados.isEmpty{
                self.estadoCollection = .erro
            }else{
                self.estadoCollection = .concluido(self.filmesEncontrados)
            }//else self.filmesEncontrados.isEmpty
        })//MovieMDB.popular
    }//func buscaPopulares
    
    
    @IBAction func favoritar(_ sender: UIButton) {
        
        //Variáveis locais
        let indexPathSelecionado = IndexPath.init(row: sender.tag, section: 0)
        var indiceFilme = sender.tag
        
        //Altera a referência de posição do Index Path
        if modoPesquisa{
            indiceFilme = estadoCollection.indicesBusca[sender.tag]
        }// if modoPesquisa
        
        //Se já estava favoritado, desfavorita da conta do usuário
        if arrayIndexPathFavoritos.contains(indexPathSelecionado){
            
            let referenciaDelecao = Database.database().reference().child("\(idUsuarioAtual ?? "nulo")/favoritos/").child("\(filmesEncontrados[indiceFilme].id ?? 0)")
            referenciaDelecao.removeValue()
            
        }else{//Senão, favorita
            arrayIndexPathFavoritos.append(indexPathSelecionado)
            
            referenciaRealtime.child("\(idUsuarioAtual ?? "")/favoritos").child("\(filmesEncontrados[indiceFilme].id ?? 0)").setValue(filmesEncontrados[indiceFilme].id ?? 0)
        }//else indexPathSelecionado
        estadoCollection = .concluido(filmesEncontrados)
    }//func favoritar
    
    //MARK: Fluxo da view
    @IBAction func sair(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            //Sucesso no logout
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let login = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(login, animated: true, completion: nil)
            
        } catch let signOutError as NSError {
            print ("Erro ao fazer logout: ", signOutError)
            let erroLogoutAlert = UIAlertController(title: "Falha no logout", message: "Verifique sua conexão com a internet", preferredStyle: .alert)
            let certoAcao = UIAlertAction(title: "Fechar", style: .default) { action in}
            erroLogoutAlert.addAction(certoAcao)
            present(erroLogoutAlert, animated: true, completion: nil)
        }//catch let signOutError as NSError
    }//func sair
    
    //MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let viewDetalhes = segue.destination as? DetalhesViewController
        
        if segue.identifier == "segueDetalhesFilme"{
            if modoPesquisa{
                viewDetalhes?.filme = filmesEncontrados[estadoCollection.indicesBusca[itemSelecionado]]
            }else{
                viewDetalhes?.filme = filmesEncontrados[itemSelecionado]
            }//else !modoPesquisa
            viewDetalhes?.favorito = favorito
        }// if segue.identifier == "segueDetalhesFilme"
    }//prepare(for segue:)
}//Fim da classe GridFilmesViewController

extension GridFilmesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    //MARK: Collection Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if modoPesquisa{
            return estadoCollection.indicesBusca.count
        }else{
            return estadoCollection.dadosFilme.count
        }//else
    }//numberOfItemsInSection
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let celula = collectionView.dequeueReusableCell(withReuseIdentifier: "CelulaFilme", for: indexPath) as! CelulaCollection
        let objFilme: Filme
        //Baseado no modo normal
        var indiceExibicao = indexPath.row
        
        if modoPesquisa{
            //Se for modo de pesquisa, altera o índice guia de exibição
            indiceExibicao = estadoCollection.indicesBusca[indexPath.row]
        }//if modoPesquisa
        else{
            //Scroll Infinito. Busca novos filmes quando o usuário chega próximo ao fim da tabela
            //Não efetua no modo pesquisa
            if indexPath.row == filmesEncontrados.count - 1{
                pagina+=1//Incrementa para a próxima página. Valor máximo == 1000, segundo API
                buscaPopulares()
            }//if indexPath.row == listaFilmes.count
        }//else !modoPesquisa
        
        
        objFilme = filmesEncontrados[indiceExibicao]
        
        //Seta URL com tamanho definido por w154, de acordo com API TMDB
        let urlImagem = URL(string: "http://image.tmdb.org/t/p/w154\(objFilme.caminhoImagem!)")
        
        celula.labelNome.text = objFilme.nome
        celula.imagePoster.sd_setImage(with: urlImagem, placeholderImage: #imageLiteral(resourceName: "carregandoPoster"), options: .highPriority, completed: nil)
        
        //Define o estado do botão de favorito
        celula.buttonFavoritar.tag = indexPath.row//Referência para favoritar o filme correto, independente dos modos normal ou pesquisa
        celula.buttonFavoritar.addTarget(self, action: #selector(favoritar(_:)), for: .touchUpInside)
        
        //Verifica se o filme atual está na lista do usuário no Firebase
        if arrayIDFavoritos.contains(filmesEncontrados[indiceExibicao].id!){
            arrayIndexPathFavoritos.append(indexPath)
        }// if arrayIDFavoritos.contains
        
        //Verifica se foi selecionado pelo usuário e se já existia no Firebase
        if arrayIndexPathFavoritos.contains(indexPath){
            celula.buttonFavoritar.setImage(#imageLiteral(resourceName: "favoritarSelecionado"), for: .normal)
        }else{
            celula.buttonFavoritar.setImage(#imageLiteral(resourceName: "favoritar"), for: .normal)
        }//else arrayIndexPathFavoritos.contains
        
        return celula
    }//cellForItemAt
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemSelecionado = indexPath.item
        
        if arrayIndexPathFavoritos.contains(indexPath){ //É um filme favorito
            favorito = true
        }// if arrayIndexPathFavoritos.contains
        
        performSegue(withIdentifier: "segueDetalhesFilme", sender: self)
    }//didSelectItemAt
}//extension UICollectionViewController

extension GridFilmesViewController: UISearchBarDelegate{
    
    //MARK: Delegate barra de pesquisa
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let textoPesquisa = self.barraPesquisa.text
        estadoCollection = .retornoBusca([])//Esvazia buscas anteriores
        arrayIndexPathFavoritos.removeAll()
        
        //Verifica se o usuário inseriu texto na barra
        if textoPesquisa == nil || textoPesquisa == "" {
            self.modoPesquisa = false
            self.view.endEditing(true)//Avisa o delegate para esconder o teclado
            estadoCollection = .concluido(filmesEncontrados)
        }//if barraPesquisa.text == nil || self.barraPesquisa.text == ""
        else{
            self.modoPesquisa = true
            
            //Armazena no vetor os índices de onde foram encontrados os nomes
            let indicesBusca = self.filmesEncontrados.indices.filter{self.filmesEncontrados[$0].nome!.localizedCaseInsensitiveContains(textoPesquisa!)}
            
            if indicesBusca.isEmpty{ //Não obteve resultados
                self.estadoCollection = .semResultado
                labelRetornoBusca.text = "Sua busca pelo nome \"\(textoPesquisa ?? "")\" não obteve resultados"
            }//if self.arrayIndicesBusca.isEmpty
            else{
                self.estadoCollection = .retornoBusca(indicesBusca)
            }//else
        }//else
    }//func searchBar(_ searchBar: UISearchBar)
}//extension UISearchBarDelegate
