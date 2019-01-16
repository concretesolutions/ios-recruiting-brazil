//
//  MoviePlaceholder.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 23/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

struct MoviePlaceholder {
	static func model1() -> Movie {
		let movie = Movie(id: 284054,
						  title: "Pantera Negra (PH)",
						  overview: "Após a morte do Rei T'Chaka (John Kani), o príncipe T'Challa (Chadwick Boseman) retorna a Wakanda para a cerimônia de coroação. Nela são reunidas as cinco tribos que compõem o reino, sendo que uma delas, os Jabari, não apoia o atual governo. T'Challa logo recebe o apoio de Okoye (Danai Gurira), a chefe da guarda de Wakanda, da irmã Shuri (Letitia Wright), que coordena a área tecnológica do reino, e também de Nakia (Lupita Nyong'o), a grande paixão do atual Pantera Negra, que não quer se tornar rainha. Juntos, eles estão à procura de Ulysses Klaue (Andy Serkis), que roubou de Wakanda um punhado de vibranium, alguns anos atrás.",
						  releaseDate: Date() ,
						  posterPath: "/wrJkShDPK4TcV0nHix3HASEmkul.jpg",
						  backdropPath: "/6P3c80EOm7BodndGBUAJHHsHKrp.jpg",
						  genreIDs: [28, 878, 53])
		return movie
	}
	
	static func error() -> Movie {
		let movie = Movie(id: 666,
						  title: "Something Went Wrong (PH)",
						  overview: "This is an error..",
						  releaseDate: Date() ,
						  posterPath: "/wrJkShDPK4TcV0nHix3HASEmkul.jpg",
						  backdropPath: "/6P3c80EOm7BodndGBUAJHHsHKrp.jpg",
						  genreIDs: [28, 878, 53])
		return movie
	}
}
