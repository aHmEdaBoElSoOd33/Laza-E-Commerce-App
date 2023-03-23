//
//  CartApi.swift
//  LazaApp
//
//  Created by Ahmed on 23/03/2023.
//

import Foundation
import Alamofire


protocol CartApiDelegate{
    
    func isDone(message : String)
    func isFail(message : String)
    
}



class CartApi{
    
    let cartUrl = RegisterApi.BASE_URL + "carts"
    let token = UserDefaults.standard.string(forKey: "userToken")
    
    var delegate : CartApiDelegate?
    
    func getFavoriteProducts(compelation:@escaping([CartItem])->Void){
        
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        
        AF.request(cartUrl, method: .get ,  headers: header).responseDecodable(of: Cart.self){ res in
            
            if res.response?.statusCode == 200 {
                switch res.result{
                case .success(let user):
                    compelation((user.data?.cart_items)!)
                case .failure(let fail):
                    print(fail.localizedDescription)
                }
            }else{
                print ("Not 200")
            }
        }
    }
    
    
    func addproductToCart(id: Int){
        
        let addToCartUrl = RegisterApi.BASE_URL + "carts"
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        let params = ["product_id":id]
        
        AF.request(addToCartUrl, method: .post, parameters: params, encoder: .json, headers: header).responseDecodable(of: AddToCartModel.self){res in
            
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
