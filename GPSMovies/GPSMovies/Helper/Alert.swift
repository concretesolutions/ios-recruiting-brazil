
import UIKit

class Alert {
    
    class func showAlert(title:String, message:String, controller:UIViewController){
        let notification = UIAlertController(title: title, message: message, preferredStyle: .alert)
        notification.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        controller.present(notification, animated: true, completion: nil)
    }
    
}
