//
//  CategoriesApi.swift
//  LazaApp
//
//  Created by Ahmed on 21/03/2023.
//

import Foundation
import Alamofire




class CategoriesApi{
    
    let categoreiesURL = RegisterApi.BASE_URL+"categories"
    
    
    func getCategories(completion: @escaping([Datum])->Void){
        
        let header = HTTPHeaders(["lang":"en"])
        
        AF.request(categoreiesURL, method: .get , headers: header).responseDecodable(of: AllCategories.self ){ res in
            
            if res.response?.statusCode == 200 {
                
                switch res.result {
                    
                case .success(let user):
                    completion((user.data?.data)!)
                case .failure(let fail):
                    print(fail.localizedDescription)
                } 
            }else {
                
                print("Not 200")
                
            }
            
        }
        
    }
    
    
    
    func getCategoriesDetails(id:Int, completion:@escaping([categoryDetails])->Void){
        
        
        let categouriesDetailUrl = RegisterApi.BASE_URL+"categories/\(id)"
        let header = HTTPHeaders(["lang":"en"])
        
        AF.request(categouriesDetailUrl, method: .get ,headers: header).responseDecodable(of: AllcategoriesDetails.self ){res in
            
            if res.response?.statusCode == 200 {
                switch res.result{
                case .success(let user):
                    completion((user.data?.data)!)
                case .failure(let fail):
                    print(fail.localizedDescription)
                }
            }else{
                print("Not 200")
            }
            
            
            
            
        }
        
    }
    
    
}
