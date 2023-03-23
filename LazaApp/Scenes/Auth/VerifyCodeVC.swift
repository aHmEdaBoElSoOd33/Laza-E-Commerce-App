//
//  VerifyCodeVC.swift
//  LazaApp
//
//  Created by Ahmed on 17/03/2023.
//

import UIKit

class VerifyCodeVC: UIViewController {

    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    
    @IBOutlet weak var txt3: UITextField!
    
    @IBOutlet weak var txt4: UITextField!
    
    
    static let ID = String(describing: VerifyCodeVC.self)
 
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        txt1.delegate = self
        txt2.delegate = self
        txt3.delegate = self
        txt4.delegate = self
        
       
    }
    
    @IBAction func confirmCodeBtn(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: SetNewPasswordVC.ID) as! SetNewPasswordVC
    
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
       
        present(vc, animated: true)
        
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
        
    }
}



extension VerifyCodeVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newStrig = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let decimalCharacter = CharacterSet.decimalDigits
        
        let decimalRange = string.rangeOfCharacter(from: decimalCharacter)
        
        if decimalRange != nil && newStrig.count <= 1 {
            return true
        }else{
            return false
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
}
