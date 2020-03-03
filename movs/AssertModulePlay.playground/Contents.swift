//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import AssertModule

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let text = UILabel()
        text.frame = CGRect(x: 10, y: 220, width: 200, height: 50)
        text.text = "Teste"
        
        
        let image = UIImageView()
        image.frame = CGRect(x: 10, y: 10, width: 300, height: 200)
        image.image = Asserts.TabBarItems.movies
        
        
        let imageByTulio = UIImage(named: "list_icon", in: Bundle(for: Asserts.TabBarItems.BundleIn.self), compatibleWith: nil)
        
        
        //print(Asserts.TabBarItems.movies)
        print(imageByTulio)
        image.backgroundColor = .gray
        
        view.addSubview(image)
        view.addSubview(text)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
