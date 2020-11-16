//
//  FilmesViewModel.swift
//  ConcreteFilmes
//
//  Created by Luis Felipe Tapajos on 09/11/2020.
//  Copyright © 2020 Luis Felipe Tapajos. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class FilmesViewModel {
    
    var filmeApi : Array<Filme> = []
    static let shared = FilmesViewModel()
    
    //Recupera a quantidade de páginas
    func getTotalPages(completionHandler: @escaping (Int) -> Void) {
        
        Alamofire.request(API_URL_MOCK, method: .get)
            .responseJSON { response in
                if response.data != nil {
                    do {
                        let json = try JSON(data: response.data!)
                        let totalPages = json["total_pages"].intValue
                        completionHandler(totalPages)
                    } catch {
                        completionHandler(0)
                    }
                }
        }
    }
    
    //Carrega os dados vindos da API do CoreData
    func loadFilmes(page: Int, completionHandler: @escaping (Array<Filme>) -> Void) {
        
        let API_URL_PAGE = "\(API_URL_MOCK)&page=\(page)"
        self.filmeApi.removeAll()
        
        Alamofire.request(API_URL_PAGE, method: .get)
            .responseJSON { response in
                if response.data != nil {
                    do {
                        let json = try JSON(data: response.data!)
                        
                        for i in 0 ..< json["results"].count {
                            let results = json["results"]
                            
                            let id = results[i]["id"].stringValue
                            let title = results[i]["title"].stringValue
                            let image = results[i]["poster_path"].stringValue
                            let ano = Help.shared.formatYear(date: results[i]["release_date"].stringValue)
                            let genero = results[i]["genre_ids"].arrayObject
                            
                            //Carrega Filmes da API
                            self.filmeApi.append(Filme(id: id, titulo: title, image: image, ano: ano, genero: genero as! Array<Int>))
                            
                            let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
                            let context = appDel.persistentContainer.viewContext
                            
                            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Filmes")
                            request.returnsObjectsAsFaults = false
                            var existFilm = false
                            do {
                                let result = try context.fetch(request)
                                for data in result as! [NSManagedObject] {
                                    let idCore = data.value(forKey: "idCore") as! String
                                    //print("\(id) == \(idCore)")
                                    
                                    if (Int(idCore) == Int(id)) {
                                        existFilm = true
                                    }
                                }
                            } catch {
                                //print("Falha ao carregar filmes")
                            }
                            
                            if (existFilm) {
                                //print("Já existe!")
                            } else {
                                let entity = NSEntityDescription.entity(forEntityName: "Filmes", in: context)
                                let newEntity = NSManagedObject(entity: entity!, insertInto: context)
                                
                                newEntity.setValue(id, forKey: "idCore")
                                newEntity.setValue(title, forKey: "titulo")
                                newEntity.setValue(image, forKey: "imagem")
                                newEntity.setValue(ano, forKey: "ano")
                                newEntity.setValue(genero, forKey: "genero")
                                
                                try context.save()
                                //print("Filme salvo!")
                            }
                            
                        }
                        completionHandler(self.filmeApi)
                    }
                    catch {
                        //print("Erro ao carregar os dados")
                        completionHandler(self.filmeApi)
                    }
                } else {
                    completionHandler(self.filmeApi)
                }
        }
    }
    
    //Remove o Banco do CoreData
    func removeCoreData() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Filmes")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
            print(error.localizedDescription)
        }
    }
    
    //Recupera a lsta de Generos
    func getGeneros(completionHandler: @escaping ([Int]) -> Void) {
        var listGeneros = [Int]()
        Alamofire.request(API_URL_Generos, method: .get)
            .responseJSON { response in
                if response.data != nil {
                    do {
                        let json = try JSON(data: response.data!)
                        //print(json)
                        
                        for i in 0 ..< json["genres"].count {
                            let results = json["genres"]
                            let id = results[i]["id"].intValue
                            listGeneros.append(id)
                        }
                        completionHandler(listGeneros)
                    }
                    catch {
                        //print("Erro ao carregar os dados")
                        completionHandler(listGeneros)
                    }
                } else {
                    completionHandler(listGeneros)
                }
        }
    }
    
    //Recupera o nome do genero
    func getGenerosName(generoId: Int, completionHandler: @escaping ([String]) -> Void) {
        var listNameGeneros = [String]()
        Alamofire.request(API_URL_Generos, method: .get)
            .responseJSON { response in
                if response.data != nil {
                    do {
                        let json = try JSON(data: response.data!)
                        //print(json)
                        
                        for i in 0 ..< json["genres"].count {
                            let results = json["genres"]
                            let id = results[i]["id"].intValue
                            let name = results[i]["name"].stringValue
                            
                            if(generoId == id) {
                                listNameGeneros.append("\(name)")
                            }
                        }
                        completionHandler(listNameGeneros)
                    }
                    catch {
                        //print("Erro ao carregar os dados")
                        completionHandler(listNameGeneros)
                        //print(error)
                    }
                }
        }
    }
    
    //Pesquisa a lista de Filmes por título
    func pesquisaFilmes(titulo: String, lista: [Filme]) -> [Filme] {
        var listaFilmes = lista
        if titulo != "" {
            listaFilmes.removeAll()
            for i in 0 ..< lista.count {
                if (lista[i].titulo.contains(titulo)) {
                    listaFilmes.append(lista[i])
                }
            }
        }
        return listaFilmes
    }
}

