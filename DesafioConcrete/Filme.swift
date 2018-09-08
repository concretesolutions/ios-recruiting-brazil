//
//  Filme.swift
//  DesafioConcrete
//
//  Created by Matheus Henrique on 06/09/2018.
//  Copyright © 2018 Concrete.Matheus Henrique. All rights reserved.
//

import Foundation

class Filme {
    
    var id: Int?
    var nome: String?
    var ano: String?
    var caminhoImagem: String?
    
    init(id: Int?, nome: String?, ano: String?, caminhoImagem: String?){
        self.id = id
        self.nome = nome
        self.ano = ano
        self.caminhoImagem = caminhoImagem
    }//init
    
}//Fim da classe
