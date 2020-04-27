//
//  BackgroundStateViewModel.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 25/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

enum BackgroundStateViewImages: String {
    case search = "NoSearchResult"
    case connection = "NoConnection"
    case movie = "NoMovie"
    case error = "Error"
}

struct BackgroundStateViewModel: Equatable {
    var title: String = "Ocoreu um erro"
    var subtitle: String = "Não conseguimos comunicar com o servidor. Tente novamente mais tarde."
    var image: BackgroundStateViewImages = .error
    var retry: String = "Tentar novamente"
    
    init(title: String?, subtitle: String?, image: BackgroundStateViewImages?, retry: String?) {
        self.title = title ?? self.title
        self.subtitle = subtitle ?? self.subtitle
        self.image = image ?? self.image
        self.retry = retry ?? ""
    }
}
