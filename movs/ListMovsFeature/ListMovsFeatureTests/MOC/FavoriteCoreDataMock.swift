
import Foundation
import ModelsFeature
open class FavoriteMovCoreDataMock: FavoriteMovCoreDataType {
    
    public init() {}
    
    public func saveFavoriteMovs(model: FavoriteMovsModel) {
        
    }
    
    public func fetchFavoriteMovs() -> [FavoriteMovsModel] {
        return []
    }
    
    public func deleteFavoriteMovs(model: FavoriteMovsModel) {
        
    }
    
    public func search(by model: FavoriteMovsModel) -> FavoriteMovsModel? {
        if model.title == "Mock Movies" {
            return model
        }
        return nil
    }
}
