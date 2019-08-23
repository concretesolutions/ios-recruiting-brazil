//
//  Database.swift
//  Movs
//
//  Created by Gustavo Caiafa on 19/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import Foundation
import SQLite

class Database{
    
    static let instance = Database()
    private let db: Connection?
    
    private let TabelaMovie = Table("Movie")
    private let MovieId = Expression<Int64>("MovieId")
    private let Titulo = Expression<String?>("Titulo")
    private let MovieIdApi = Expression<Int64>("MovieIdApi")
    private let Descricao = Expression<String?>("Descricao")
    private let Data = Expression<Int?>("Data")
    private let LinkFoto = Expression<String?>("LinkFoto")
    private let Generos = Expression<String?>("Generos")

    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            db = try Connection("\(path)/Database.sqlite3")
        } catch {
            db = nil
            print ("não conseguiu abrir o database")
        }
    }
    
    func deletarBanco() -> Bool{
        do {
            try db?.run(TabelaMovie.drop())
            print("Deletou a tabela")
            return true
        } catch {
            print("delete failed: \(error)")
            return false
        }
    }
    
    func criarTabelaMovie() -> Bool{
        do { // criando tabela Categoria
            try db!.run(TabelaMovie.create(ifNotExists: true) { table in
                table.column(MovieId, primaryKey: true)
                table.column(Titulo)
                table.column(Descricao)
                table.column(Data)
                table.column(LinkFoto)
                table.column(Generos)
                table.column(MovieIdApi)
            })
            return true
        } catch {
            print("Nao conseguiu criar a tabela: \(error)")
            return false
        }
    }
    
    func addMovie(movieidapi : Int64,titulo: String?,descricao: String?,data: Int?,
                  linkfoto: String?,generos: String?) -> Bool {
        do {
            let insert = TabelaMovie.insert(Titulo <- titulo,
                                            Descricao <- descricao,
                                            Data <- data,
                                            LinkFoto <- linkfoto,
                                            Generos <- generos,
                                            MovieIdApi <- movieidapi)
            try db!.run(insert)
            return true
        } catch {
            print("Nao conseguiu inserir na tabela: \(error)")
            return false
        }
    }
    
    func deleteMovie(iid: Int64) -> Bool {
        do {
            let itens = TabelaMovie.filter(MovieId == iid)
            try db!.run(itens.delete())
            return true
        } catch {
            print("Deletar itens falhou \(error)")
            return false
        }
    }
    
    /*
     Ao tentar pegar os filmes, caso o erro seja table inexistente, tentaremos deletar o banco todo
     e depois criar a tabela novamente, para assim dar get.
     Caso de erro ao deletar, apenas criaremos a tabela novamente e daremos get.
     */
    func getMovies() -> [MoviesModelLocal]? {
        var movies = [MoviesModelLocal]()
        
        do {
            for movie in try db!.prepare(self.TabelaMovie) {
                movies.append(MoviesModelLocal(
                    movieid: movie[MovieId],
                    titulo: movie[Titulo],
                    descricao: movie[Descricao],
                    data: movie[Data],
                    linkfoto: movie[LinkFoto],
                    generos: movie[Generos],
                    movieidapi : movie[MovieIdApi]))
            }
            return movies
        }
        
        catch let Result.error(message, code, statement) {
            if(message == "no such table: Movie"){
                if(deletarBanco()){
                    if(criarTabelaMovie()){
                        return getMoviesAgain()
                    }
                }
                else{
                    if(criarTabelaMovie()){
                        return getMoviesAgain()
                    }
                }
            }
            return nil
        }
        
        catch {
            print("Nao conseguiu dar retrieve nos filmes: \(error)")
            return nil
        }
    }
    
    private func getMoviesAgain() -> [MoviesModelLocal]? {
        print("Get again")
        var movies = [MoviesModelLocal]()
        do {
            for movie in try db!.prepare(self.TabelaMovie) {
                movies.append(MoviesModelLocal(
                    movieid: movie[MovieId],
                    titulo: movie[Titulo],
                    descricao: movie[Descricao],
                    data: movie[Data],
                    linkfoto: movie[LinkFoto],
                    generos: movie[Generos],
                    movieidapi : movie[MovieIdApi]))
            }
            return movies
        } catch {
            return nil
        }
    }
}
