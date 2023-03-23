//
//  ForgetPasswordVC.swift
//  LazaApp
//
//  Created by Ahmed on 17/03/2023.
//

import UIKit

class ForgetPasswordVC: UIViewController {

    static let ID = String(describing: ForgetPasswordVC.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    @IBAction func ConfirmMailVC(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: VerifyCodeVC.ID) as! VerifyCodeVC
    
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
       
        present(vc, animated: true)
        
        
        
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        
        dismiss(animated: true)
        
    }
    
   
}
