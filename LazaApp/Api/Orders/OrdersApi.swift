//
//  OrdersApi.swift
//  LazaApp
//
//  Created by Ahmed on 26/03/2023.
//

import Foundation
import Alamofire

protocol AddOrderDelegate{
    
    func AddorderIsDone(message:String)
    func AddorderIsFail(message:String)
    
 
    
}

protocol CancelOrderDelegate{
    func CancelOrderIsDone(message:String)
    func CancelOrderIsFail(message:String)
}

class OrdersApi{
    
    let ordersUrl = RegisterApi.BASE_URL + "orders"
    let token = UserDefaults.standard.string(forKey: "userToken")
    
    var delegate : AddOrderDelegate?
    
    
    func getOrders(compelation:@escaping([OrderModelDataDetails])->Void){
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        
        AF.request(ordersUrl, method: .get ,  headers: header).responseDecodable(of: OrderModel.self){ res in
            
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
    
    
    
    
    func AddOrder(address_id: String , payment_method : String = "1" , use_points : String = "false" , promo_code_id : String?){
        
        let addOrderUrl = ordersUrl
        
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        let params = ["address_id":address_id, "payment_method":payment_method, "use_points":use_points, "promo_code_id":promo_code_id]
        
        AF.request(addOrderUrl , method: .post, parameters: params, encoder: .json, headers: header).responseDecodable(of: AddOrderModel.self){ res in
            if res.response?.statusCode == 200 {
                switch res.result{
                case .success(let user):
                    self.delegate?.AddorderIsDone(message: user.message!)
                case .failure(let fail):
                    self.delegate?.AddorderIsFail(message: fail.localizedDescription)
                }
            }else{
                print("Not 200")
            }
        }
    }
    
    
    
    func getOrderDetails(id:Int,complition:@escaping(OrderDetailsModelData,[OrderDetailsProductModelData])->Void){
        
        let orderDetailsUrl = ordersUrl + "/\(id))"
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        
        AF.request(orderDetailsUrl, method: .get,  headers: header).responseDecodable(of:  OrderDetailsModel.self ){ res in
            
            print(res.result)
            
            if res.response?.statusCode == 200 {
                switch res.result {
                case .success(let user):
                    complition(user.data!, (user.data?.products!)!)
                case .failure(let fail):
                    print(fail.localizedDescription)
                }
            }else{
                print("Not 200")
            }
            
        }
    }
    
    
    var cancelDelegate : CancelOrderDelegate?
    
    func cancelOrder(id:Int){
        let cancelOrderUrl = ordersUrl + "/\(id)/cancel"
        
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        
        AF.request(cancelOrderUrl , method: .get , headers: header).responseDecodable(of: CancelOrderModel.self){ res in
            if res.response?.statusCode == 200 {
                switch res.result{
                case .success(let user):
                    self.cancelDelegate?.CancelOrderIsDone(message: user.message!)
                case .failure(let fail):
                    self.cancelDelegate?.CancelOrderIsFail(message: fail.localizedDescription)
                }
            }else{
                print("Not 200")
            }
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
}
