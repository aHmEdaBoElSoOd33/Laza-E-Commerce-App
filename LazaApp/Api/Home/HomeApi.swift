//
//  HomeApi.swift
//  LazaApp
//
//  Created by Ahmed on 20/03/2023.
//

import Foundation
import Alamofire


protocol HomeApiDelegate{
    
    func profireDataIsDone(Data: DataClass)
    func profileDataIsFail(masssage: String)
    
    func logoutIsDone(massage:String)
    func logoutIsFail(massage:String)
}

class HomeApi{
    
    let token = UserDefaults.standard.string(forKey: "userToken")
    let UserProfileUrl = RegisterApi.BASE_URL + "profile"
    let logOutUrl = RegisterApi.BASE_URL+"logout" 
    var delegate : HomeApiDelegate?
    
    func getUserProfileData(){ 
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        let params : [String:String]? = nil
        
        AF.request(UserProfileUrl, method: .get, parameters : params , encoder: .json , headers:  header).responseDecodable(of: UserRegisterModel.self ){ res in
            
            if res.response?.statusCode == 200 {
                   
                switch res.result{
                case .success(let user):
                    self.delegate?.profireDataIsDone(Data: user.data!)
                    print(user.data?.name)
                case .failure(let fail):
                    self.delegate?.profileDataIsFail(masssage:fail.localizedDescription)
                }
            }else {
                print ("not 200")
                
            }
        }
    }
    
    
    
    
    func LogoutfromDataBase(){
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        
        let params = ["fcm_token":"SomeFcmToken"]
        
        AF.request(logOutUrl, method: .post, parameters : params , encoder: .json , headers:  header).responseDecodable(of: UserRegisterModel.self ){ res in
            
            if res.response?.statusCode == 200 {
                   
                switch res.result{
                case .success(let user):
                    self.delegate?.logoutIsDone(massage: user.message!)
                    print(user.data?.name)
                case .failure(let fail):
                    self.delegate?.logoutIsFail(massage: fail.localizedDescription)
                }
            }else {
                print (res.response?.statusCode)
                
            }
        }
    }
    
    
    let homeUrl = RegisterApi.BASE_URL + "home"
    
    func getHomeData(completion:@escaping([Product]?,Error?)->Void){
        
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        
        AF.request(homeUrl, method: .get,headers: header ).responseDecodable(of: HomeVCModel.self ){ res in
            
          if res.response?.statusCode == 200 {
                switch res.result { 
                case .success(let user):
                    completion((user.data?.products)!, nil)
                case .failure(let fail):
                    completion(nil, fail)
                }
            }else{
                
                print("Not 200")
                
            }
        
            
            
            
            
            
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
}
