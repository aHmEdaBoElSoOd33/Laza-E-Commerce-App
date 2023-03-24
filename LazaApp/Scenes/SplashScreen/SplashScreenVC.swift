//
//  SplashScreenVC.swift
//  LazaApp
//
//  Created by Ahmed on 11/03/2023.
//

import UIKit



class SplashScreenVC: UIViewController {
    
    static let ID = String(describing: SplashScreenVC.self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        print(UserDefaults.standard.string(forKey: "userToken"))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ){
            
            if UserDefaults.standard.string(forKey: "userToken") == nil{
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: OnboardingVC.ID) as! OnboardingVC
                
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: ContainerVC.ID) as! ContainerVC
                
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
                
                
            }
            
            
           
            
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
