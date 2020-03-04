import UIKit

protocol MovieTabItemCreator {
    func createMovieTabBarItem() -> UITabBarItem
    func with(title: String) -> UITabBarItem
    func with(image: UIImage) -> UITabBarItem
}

extension UITabBarItem: MovieTabItemCreator {
    private var normalColor: UIColor {
        ColorName.secondary.color.withAlphaComponent(0.6)
    }

    private var selectedColor: UIColor {
        ColorName.secondary.color
    }

    func createMovieTabBarItem() -> UITabBarItem {
        setTitleTextAttributes([.foregroundColor: normalColor], for: .normal)
        setTitleTextAttributes([.foregroundColor: selectedColor], for: .selected)
        return self
    }

    func with(title: String) -> UITabBarItem {
        self.title = title
        return self
    }

    func with(image: UIImage) -> UITabBarItem {
        self.image = image.withTintColor(normalColor)
        selectedImage = image.withTintColor(selectedColor)
        return self
    }
}
