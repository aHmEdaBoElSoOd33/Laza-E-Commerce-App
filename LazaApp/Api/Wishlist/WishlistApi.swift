//
//  WishlistApi.swift
//  LazaApp
//
//  Created by Ahmed on 22/03/2023.
//

import Foundation
import Alamofire


protocol WishlistApiDelegate{
    
    func isDone(message : String)
    func isFail(message : String)
    
}



class WishlistApi{
    
    let wishlistUrl = RegisterApi.BASE_URL + "favorites"
    let token = UserDefaults.standard.string(forKey: "userToken")
    
    var delegate : WishlistApiDelegate?
    
    func getFavoriteProducts(compelation:@escaping([WishlistData])->Void){
      
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        
        AF.request(wishlistUrl, method: .get ,  headers: header).responseDecodable(of: Wishlist.self){ res in
            
            if res.response?.statusCode == 200 {
                switch res.result{
                case .success(let user):
                    compelation((user.data?.data)!)
                case .failure(let fail):
                    print(fail.localizedDescription)
                }
            }else{
                print ("Not 200")
            }
        } 
    }
    
    
    
    func addproductToFavoriets(id: Int){
        
        let addToWishlistUrl = RegisterApi.BASE_URL + "favorites"
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        let params = ["product_id":id]
        
        AF.request(addToWishlistUrl, method: .post, parameters: params, encoder: .json, headers: header).responseDecodable(of: AddWishlistModel.self){res in
            
            if res.response?.statusCode == 200 {
                switch res.result{
                    
                case .success(let user):
                    self.delegate?.isDone(message: user.message!)
                case .failure(let fail):
                    self.delegate?.isFail(message: fail.localizedDescription)
                }  
            }else{
                print("not 200")
            }
            
        }
         
        
        
    }
    
    
    
    
}
