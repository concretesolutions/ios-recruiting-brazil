//
//  Extensions.swift
//  Movs
//
//  Created by Gustavo Caiafa on 14/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import UIKit

public class Utils{
    
    struct Global {
        static var genresModel : GenreResultModel? = nil
        static var favoritesModel : [MoviesModelLocal]? = [MoviesModelLocal]()
        static var hasFavoritesChangedInMovies = false
        static var hasFavoritesChangedInFavorites = false
        static var hasFavoritesBeenDeleted = false
        static var deletedFavoritesId : [Int64]? = []
    }
}

extension UIView{
    
    public func arredondaView() {
        DispatchQueue.main.async {
            self.contentMode = UIView.ContentMode.scaleAspectFill
            self.layer.cornerRadius = self.frame.height / 2
            self.layer.masksToBounds = false
            self.clipsToBounds = true
        }
    }
}

func showAlertaController(_ controller : UIViewController, texto : String,titulo : String,dismiss:Bool){
    let alertController = UIAlertController(title: titulo, message: texto, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
        if(dismiss){
            controller.dismiss(animated: true, completion: nil)
        }
    }
    alertController.addAction(OKAction)
    controller.present(alertController, animated: true) {
    }
}

extension String{
    
    func toDateYear()-> Int?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale =  NSLocale(localeIdentifier: "pt_BR") as Locale
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        
        let calendar = Calendar.current
        return calendar.component(.year, from: date ?? Date())
    }
    
}

extension Date{
    
    func toString() -> String? {
        var str = "N/D"
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale =  NSLocale(localeIdentifier: "pt_BR") as Locale
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        str = dateFormatter.string(from: self)
        
        return str
    }
}


