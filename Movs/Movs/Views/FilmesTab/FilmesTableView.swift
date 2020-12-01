//
//  Testes.swift
//  Movs
//
//  Created by Gabriel Coutinho on 01/12/20.
//
//
//import Foundation
//import UIKit
//
//import Alamofire
//import AlamofireImage
//
//class FilmesTableView: UITableView {
//
//
//
//    override func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
//        let filme = self.filmes[indexPath.row]
//        let cell = FilmeTableViewCell()
//        cell.titulo.text = filme.title
//        AF.request("https://image.tmdb.org/t/p/w500/\(filme.posterPath ?? "")").responseImage { image in
//            if case .success(let image) = image.result {
//                cell.capa.image = image
//            }
//        }
//        return cell
//    }
//}
