//
//  SetNewPasswordVC.swift
//  LazaApp
//
//  Created by Ahmed on 17/03/2023.
//

import UIKit

class SetNewPasswordVC: UIViewController {
    
    
    static let ID = String(describing: SetNewPasswordVC.self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
         
    }
     

    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
}
