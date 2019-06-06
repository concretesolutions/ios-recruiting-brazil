
import Foundation

enum TypeMessage:String {
    case successAddMyRepositorys = "SuccessAddMyRepositorys"
    case successRemoveMyRepositorys = "SuccessRemoveMyRepositorys"
    case errorEmptyRepository = "ErrorEmptyRepository"
    case errorNetwork = "ErrorNetwork"
    case errorFindRepository = "ErrorFindRepository"
    case errorGeneric = "ErrorGeneric"
    case notInternet = "NotInternet"
}

//MARK: - Singleton
class MessageHelper {
    static let instance = MessageHelper()
    private init(){}
}

extension MessageHelper{
    func getPropertyMessage(typeMessage:TypeMessage) -> String{
        if let messageDictionary = self.getBundleInDictionary(), let message = messageDictionary[typeMessage.rawValue]{
            return message
        }
        return "Ocorreu um erro inesperado."
    }
    
    private func getBundleInDictionary() -> Dictionary<String,String>?{
        guard let path = Bundle.main.path(forResource: "Messages", ofType: "plist"),
            let data = FileManager.default.contents(atPath: path) else {
                return nil
        }
        do {
            let messageDictionary = try PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.ReadOptions(), format: nil)
            guard let dictionary = messageDictionary as? Dictionary<String,String> else{
                return nil
            }
            return dictionary
        } catch  {
            return nil
        }
    }
}
