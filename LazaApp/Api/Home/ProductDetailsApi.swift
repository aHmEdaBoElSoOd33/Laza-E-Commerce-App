//
//  ProductDetailsApi.swift
//  LazaApp
//
//  Created by Ahmed on 22/03/2023.
//

import Foundation
import Alamofire
import UIKit

class ProductDetailsApi{
    
    let token = UserDefaults.standard.string(forKey: "userToken")
    
    func getProuductDetailsInfo(id:Int,complaition:@escaping(ProductDetailsInfo?,String?)->Void){
      
        let productDetailsUrl = RegisterApi.BASE_URL+"products/\(id)"
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        
        AF.request(productDetailsUrl, method: .get ,headers: header).responseDecodable(of: ProductDetails.self ){res in
            
            if res.response?.statusCode == 200 {
                switch res.result{
                case .success(let user):
                    print(user)
                    complaition(user.data!,nil)
                case .failure(let fail):
                    complaition(nil,"There are no Details")
                    print(fail.localizedDescription)
                }
            }else{
                print("Not 200")
            }
        }
    } 
}



