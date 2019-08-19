//
//  General.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 19/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import Foundation

func formatarData(valor: String, formatoAtual: String, formatoNovo:String) -> String{
    let atual = DateFormatter()
    atual.dateFormat = formatoAtual
    
    let novo = DateFormatter()
    novo.dateFormat = formatoNovo
    
    let valorNovo:String = novo.string(from: atual.date(from: valor)!)
    return "\(valorNovo)"
}
