
import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
            self.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    public func pulseAnimation(scaleX:CGFloat, scaleY:CGFloat, timer:Double, alpha:CGFloat?, _ complete:((_ result:Bool?)-> Void)?){
        UIView.animate(withDuration: timer, animations: {
            self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            self.alpha = alpha == nil ? 1 : alpha!
        }) { (result) in
            self.transform = .identity
            complete?(result)
        }
    }

}
