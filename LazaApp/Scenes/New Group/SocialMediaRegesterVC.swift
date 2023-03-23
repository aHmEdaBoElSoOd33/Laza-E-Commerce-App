//
//  SocialMediaRegesterVC.swift
//  LazaApp
//
//  Created by Ahmed on 13/03/2023.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class SocialMediaRegesterVC: UIViewController {

    
    @IBOutlet weak var facebookLoginBtn: UIButton!
    static let ID = String(describing: SocialMediaRegesterVC.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Check if the user is logged in
        if let user = Auth.auth().currentUser {
            // User is logged in
            print("User is logged in with uid: \(String(describing: user.email))")
        } else {
            // User is logged out
            print("User is logged out")
        }
        
        
        // Do any additional setup after loading the view.
    }
    
 
    @IBAction func facebookLoginBtn(_ sender: UIButton) {
        
        let loginManager = LoginManager()
        loginManager.logIn(viewController: self, configuration: .init(permissions: ["public_profile", "email"])) { result in
                   switch result {
                   case .cancelled:
                       print("Login cancelled")
                   case .failed(let error):
                       print("Login failed with error: \(error.localizedDescription)")
                   case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                       print("Login success with granted permissions: \(grantedPermissions), declined permissions: \(declinedPermissions), access token: \(accessToken)")
                       
                       // Authenticate with Firebase
                       if let tokenString = accessToken?.tokenString {
                           let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
                           Auth.auth().signIn(with: credential) { authResult, error in
                               if let error = error {
                                   print("Firebase authentication failed with error: \(error.localizedDescription)")
                               } else {
                                   
                                   let vc = self.storyboard?.instantiateViewController(withIdentifier: ContainerVC.ID) as! ContainerVC
                                   
                                   vc.modalPresentationStyle = .fullScreen
                                   self.present(vc, animated: true)
                                   
                                   print("Firebase authentication succeeded with user: \(authResult?.user.uid ?? "")")
                                   
                                   // Navigate to the next screen
                               }
                           }
                       } else {
                           print("Failed to get access token from Facebook login")
                       }
                   }
               }
           }
    
    
    
    @IBAction func twitterLoginBtn(_ sender: Any) {
        
        
        
        
        
    }
    
  
    @IBAction func googleLoginBtn(_ sender: Any) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else {return}
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { res, error in
            
            guard error == nil else{
                print("error from auth")
                return
            }
            
            guard let user = res?.user,let idToken = user.idToken else{
                print("error in id token or user")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { res, error in
               
                if let error = error {
                    print("Firebase authentication failed with error: \(error.localizedDescription)")
                } else {
                    print("Firebase authentication succeeded with user: \(res?.user.uid ?? "")")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: ContainerVC.ID) as! ContainerVC 
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                    // Navigate to the next screen
                }
                
            }
            
            
            
        }
        
        
    } 
    
    @IBAction func signInOrRegesterBtns(_ sender: UIButton) {
        switch sender.tag{
        case 1 :
            navigete(state: "Sign In")
        default:
            navigete(state: "Create Account")
        }
    }
    
    
    
    
    func navigete(state : String){
        let vc = storyboard?.instantiateViewController(withIdentifier: LoginAndRegerterVC.ID) as! LoginAndRegerterVC
        vc.state = state
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        self.dismiss(animated: true)
        
    }
    
}
