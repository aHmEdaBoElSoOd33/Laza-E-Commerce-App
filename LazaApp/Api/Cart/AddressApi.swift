//
//  AddressApi.swift
//  LazaApp
//
//  Created by Ahmed on 25/03/2023.
//

import Foundation
import Alamofire

class AddressApi{
    let addressUrl = RegisterApi.BASE_URL + "addresses"
    let token = UserDefaults.standard.string(forKey: "userToken")
    
    
    func getAddressData(compilition:@escaping ([AddressDetailsData])->Void){
       
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        
        AF.request(addressUrl, method: .get,headers: header).responseDecodable(of: Address.self){ res in
            if res.response?.statusCode == 200 {
                switch res.result{
                case .success(let user):
                    compilition((user.data?.data)!)
                case .failure(let fail):
                    print(fail.localizedDescription)
                }  
            }else{
                print("Not 200")
            }
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
}
