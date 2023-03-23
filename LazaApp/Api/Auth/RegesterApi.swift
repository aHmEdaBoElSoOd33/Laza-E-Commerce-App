//
//  RegesterApi.swift
//  LazaApp
//
//  Created by Ahmed on 20/03/2023.
//

import Foundation
import Alamofire

protocol RegisterApiDelegate{ 
    func RegisterIsDone(message: String)
    func RegisterIsFail(message: String)
    
    func LoginIsDone(massage : String)
    func LoginIsFail(massage : String)
    
}
 

class RegisterApi{
    
    static let BASE_URL = "https://student.valuxapps.com/api/"
    let regesterURl = BASE_URL+"register"
    let loginURL = BASE_URL+"login"
    
    var delegate : RegisterApiDelegate?
    
    
    func userRegester(_ name:String,_ email: String , _ phone:String ,_ password : String){
        
        
        let params = ["name":name, "email":email, "phone":phone, "password":password]
        let headers = HTTPHeaders(["lang" : "en"])
        
        AF.request(regesterURl, method: .post, parameters: params, encoder: .json, headers: headers).responseDecodable(of: UserRegisterModel.self){ res in
            
            if res.response?.statusCode == 200{
                
                switch res.result{
                case .success(let user):
                    UserDefaults.standard.set(user.data?.token, forKey: "userToken")
                    self.delegate?.RegisterIsDone(message: user.message!) 
                case .failure(let fail):
                    self.delegate?.RegisterIsFail(message: fail.localizedDescription)
                    print(fail.localizedDescription)
                }
            }else{
                print("Not 200")
                
            }
            
        }
        
    }
    
    
    func userLogin(_ email: String , _ password : String){
         
        let params = ["email":email , "password":password]
        let headers = HTTPHeaders(["lang" : "en"])
        
        AF.request(loginURL, method: .post, parameters: params, encoder: .json, headers: headers).responseDecodable(of: UserRegisterModel.self){ res in
            
            if res.response?.statusCode == 200{
                
                switch res.result{
                case .success(let user):
                    UserDefaults.standard.set(user.data?.token, forKey: "userToken")
                    self.delegate?.LoginIsDone(massage: user.message!)
                    print(user.data?.token)
                case .failure(let fail):
                    self.delegate?.LoginIsFail(massage: fail.localizedDescription)
                    print(fail.localizedDescription)
                }
            }else{
                print("Not 200")
                
            }
            
        }
    }
    
}
