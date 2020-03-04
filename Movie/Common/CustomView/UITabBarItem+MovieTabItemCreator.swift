import UIKit

protocol MovieTabItemCreator {
    func createMovieTabBarItem() -> UITabBarItem
    func with(title: String) -> UITabBarItem
    func with(image: UIImage, selectedImage: UIImage) -> UITabBarItem
}

extension UITabBarItem: MovieTabItemCreator {
    func createMovieTabBarItem() -> UITabBarItem {
        let color = ColorName.secondary.color
        setTitleTextAttributes([.foregroundColor: color.withAlphaComponent(0.6)], for: .normal)
        setTitleTextAttributes([.foregroundColor: color], for: .selected)
        return self
    }

    func with(title: String) -> UITabBarItem {
        self.title = title
        return self
    }

    func with(image: UIImage, selectedImage: UIImage) -> UITabBarItem {
        self.image = image
        self.selectedImage = selectedImage
        return self
    }
}
