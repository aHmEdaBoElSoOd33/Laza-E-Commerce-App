//
//  OnboardingVC.swift
//  LazaApp
//
//  Created by Ahmed on 11/03/2023.
//

import UIKit

class OnboardingVC: UIViewController {
    //MARK: - IBOutlets
    
      
    
    //MARK: - Variables
    
    
    
    static let ID = String(describing: OnboardingVC.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

         
    }
    
    
    //MARK: - IBActions

    @IBAction func skipButton(_ sender: Any) {
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: SocialMediaRegesterVC.ID) as! SocialMediaRegesterVC
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
        
        
        
    }
     

}
