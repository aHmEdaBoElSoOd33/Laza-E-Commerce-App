//
//  File.swift
//  LazaApp
//
//  Created by Ahmed on 11/03/2023.
//
import UIKit


extension UIView{
    
    @IBInspectable var cornerRadius:CGFloat{
        
        get{
            return 0
        }
        set{
            self.layer.cornerRadius = newValue
        }
        
    }
    
}



extension UITextField{
        @IBInspectable var placeHolderColor: UIColor? {
            get {
                return self.placeHolderColor
            }
            set {
                self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
            }
        }
    
    
    func setIcon(_ image: UIImage) {
       let iconView = UIImageView(frame:
                      CGRect(x: 10, y: 5, width: 20, height: 20))
       iconView.image = image
       let iconContainerView: UIView = UIView(frame:
                      CGRect(x: 20, y: 0, width: 40, height: 30))
        iconView.tintColor = .white
       iconContainerView.addSubview(iconView)
       leftView = iconContainerView
       leftViewMode = .always
    }
}

 
extension UITextField {
    @IBInspectable var underLineTF: Bool {
        get {
            return false
        } set {
            let underLineLayer = CALayer()
            underLineLayer.frame = CGRect(x: 0, y: self.frame.height + 5, width: self.frame.width - 20 , height: 1.0)
            underLineLayer.backgroundColor = UIColor.placeholderText.cgColor
            self.borderStyle = .none
            self.layer.addSublayer(underLineLayer) 
 
        }
    }
}
