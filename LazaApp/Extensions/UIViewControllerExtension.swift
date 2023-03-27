//
//  UIViewControllerExtension.swift
//  LazaApp
//
//  Created by Ahmed on 19/03/2023.
//

import Foundation
import UIKit
import Network


extension UIViewController{
       

    func checkInternetConnection(completionHandler: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.start(queue: queue)

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
            monitor.cancel()
        }
    }
    
    
    
    func setupCell(collectionView : UICollectionView , ID :String ){
        
        let nib = UINib(nibName: ID , bundle: nil )
        collectionView.register(nib, forCellWithReuseIdentifier: ID)
        
    }
    
    
    func tabBarNavigation(pageindex:Int){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: ContainerVC.ID) as! ContainerVC
        vc.selectedPage = pageindex
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
        
        
        
    }
    
    func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
     
    
    func showALert(message:String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
    func showAlertWithNavigation(massege : String ) {
        
        let alertController = UIAlertController(title: "Alert", message: massege, preferredStyle: .alert)

        let defaultAction = UIAlertAction(title: "OK", style: .default) { _ in
            let vc = self.storyboard?.instantiateViewController(identifier: ContainerVC.ID) as! ContainerVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        alertController.addAction(defaultAction)

        present(alertController, animated: true, completion: nil)
    }
    
    
    func showAlertLogOut(massege : String ) {
        
        let alertController = UIAlertController(title: "Alert", message: massege, preferredStyle: .alert)

        let defaultAction = UIAlertAction(title: "OK", style: .default) { _ in
            let vc = self.storyboard?.instantiateViewController(identifier: SocialMediaRegesterVC.ID) as! SocialMediaRegesterVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        alertController.addAction(defaultAction)

        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertDeleteAddress(massege : String ) {
        
        let alertController = UIAlertController(title: "Alert", message: massege, preferredStyle: .alert)

        let defaultAction = UIAlertAction(title: "OK", style: .default) { _ in
            let vc = self.storyboard?.instantiateViewController(identifier: CartVC.ID) as! CartVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        alertController.addAction(defaultAction)

        present(alertController, animated: true, completion: nil)
    }
    
    
     func activityIndicator(style: UIActivityIndicatorView.Style = .medium,
                                       frame: CGRect? = nil,
                                       center: CGPoint? = nil) -> UIActivityIndicatorView {
       
        let activityIndicatorView = UIActivityIndicatorView(style: style)
      
        if let frame = frame {
            activityIndicatorView.frame = frame
        }
       
        if let center = center {
            activityIndicatorView.center = center
        }
      
        return activityIndicatorView
    }
}
