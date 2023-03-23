//
//  LoginAndRegerterVC.swift
//  LazaApp
//
//  Created by Ahmed on 13/03/2023.
//

import UIKit

class LoginAndRegerterVC: UIViewController  {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var userNameStack: UIStackView!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var emailStack: UIStackView!
    @IBOutlet weak var phoneStack: UIStackView!
    @IBOutlet weak var signUpAndLoginBtn: UIButton!
    @IBOutlet weak var termsStack: UIStackView!
    
    
    //MARK: - Variables
    
    static let ID = String(describing: LoginAndRegerterVC.self)
    var state : String = ""
    var api = RegisterApi()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        print(state)
        if state == "Sign In"{
            loginState()
        }else{
            signUpState()
        }
        
        api.delegate = self
    }
    
    //MARK: - Functions
    
    func loginState(){
        signUpAndLoginBtn.setTitle("Login", for: .normal)
        pageTitle.text = "Welcome"
        subTitle.isHidden = false
        forgetPasswordBtn.isHidden = false
        userNameStack.isHidden = true
        phoneStack.isHidden = true
        termsStack.isHidden = false
    }
    
    
    func signUpState(){
        
        signUpAndLoginBtn.setTitle("Sign Up", for: .normal)
        pageTitle.text = "Sign Up"
        subTitle.isHidden = true
        forgetPasswordBtn.isHidden = true
        userNameStack.isHidden = false
        phoneStack.isHidden = false
        termsStack.isHidden = true
        
    }
    
    
    
    func validateForLogin(){
        
        guard let email = emailTxtField.text, !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            showALert(message: "please enter Email")
            return
        }
        
        guard let password = passwordTxtField.text, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            showALert(message: "please enter Password")
            return
        }
        
        api.userLogin(email, password)
        
        
    }
    
    
    
    func validateForRegister(){
        
        guard let name = usernameTxtField.text, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            showALert(message: "please enter Username")
            return
        }
        
        guard let email = emailTxtField.text, !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            showALert(message: "please enter Email")
            return
        }
        
        guard let phone = phoneTxtField.text, !phone.trimmingCharacters(in: .whitespaces).isEmpty else {
            showALert(message: "please enter Phone")
            return
        }
        guard let password = passwordTxtField.text, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            showALert(message: "please enter Password")
            return
        }
        
        api.userRegester(name, email, phone, password)
        
    }
    
    
    //MARK: - IBActions
    
    @IBAction func forgetPasswordBtn(_ sender: Any) {
        let vc =  storyboard?.instantiateViewController(withIdentifier: ForgetPasswordVC.ID) as! ForgetPasswordVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true) 
    }
    
    
 
    @IBAction func signUpAndLoginBtn(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Login"{
            
            validateForLogin()
            
        }else{
            
            validateForRegister()
        }
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func termsBtn(_ sender: Any) {
        
        
    }
    
 
}



extension LoginAndRegerterVC : RegisterApiDelegate {
    func LoginIsDone(massage: String) {
        
        if UserDefaults.standard.string(forKey: "userToken") == "" || UserDefaults.standard.string(forKey: "userToken") == nil{
            showALert(message: massage)
        }else{
            showAlertWithNavigation(massege: massage)
        }
    }
    
    func LoginIsFail(massage: String) {
        showALert(message: massage)
    }
    
    
    func RegisterIsDone(message : String) {
        if UserDefaults.standard.string(forKey: "userToken") == "" || UserDefaults.standard.string(forKey: "userToken") == nil{
            
            showALert(message: message)
        }else{
            showAlertWithNavigation(massege: message)
        }
        
        } 
    func RegisterIsFail(message : String) {
        showALert(message: message)
    }
}
