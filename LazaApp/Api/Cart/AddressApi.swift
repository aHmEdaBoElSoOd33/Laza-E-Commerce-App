//
//  AddressApi.swift
//  LazaApp
//
//  Created by Ahmed on 25/03/2023.
//

import Foundation
import Alamofire

protocol AddressApiDelegate{
    
    func AddAdressIsDone(message:String)
    func AddAdressIsFail(message:String)
      
    func UpdateAdressIsDone(message:String)
    func UpdateAdressIsFail(message:String)
    
    func deleteAddressIsDone(message:String)
    func deleteAddressIsFail(message:String)
}
  
class AddressApi{
    let addressUrl = RegisterApi.BASE_URL + "addresses"
    let token = UserDefaults.standard.string(forKey: "userToken")
    var delegate : AddressApiDelegate?
    
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
    
 
    
    func AddAddress( name :String ,city:String,region:String,details:String ,latitude:String,longitude:String,notes:String){
        
        let addAdressUrl = addressUrl 
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        let params = ["name":name, "city":city, "region":region, "details":details,"latitude":latitude,"longitude":longitude,"notes":notes]
        
        AF.request(addAdressUrl , method: .post, parameters: params, encoder: .json, headers: header).responseDecodable(of: AddUpdateDeleteAdreessModel.self){ res in
            if res.response?.statusCode == 200 {
                switch res.result{
                    
                case .success(let user):
                    self.delegate?.AddAdressIsDone(message: user.message!)
                case .failure(let fail):
                    self.delegate?.AddAdressIsFail(message: fail.localizedDescription)
                }
            }else{
                print("Not 200")
            }
        }
        
        
        
        
    }
    
    
    
    
    func UpdateAddress(id: Int , name :String ,city:String,region:String,details:String ,latitude:String,longitude:String,notes:String){
        
        let updateAdressUrl = addressUrl + "/\(id)"
        
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        let params = ["name":name, "city":city, "region":region, "details":details,"latitude":latitude,"longitude":longitude,"notes":notes]
        
        AF.request(updateAdressUrl , method: .put, parameters: params, encoder: .json, headers: header).responseDecodable(of: AddUpdateDeleteAdreessModel.self){ res in
            if res.response?.statusCode == 200 {
                switch res.result{
                case .success(let user):
                    self.delegate?.UpdateAdressIsDone(message: user.message!)
                case .failure(let fail):
                    self.delegate?.UpdateAdressIsFail(message: fail.localizedDescription)
                }
            }else{
                print("Not 200")
            }
        }
    }
    
    
    
    func DeleteAddress(id: Int){
        
        let deleteAdressUrl = addressUrl + "/\(id)"
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        AF.request(deleteAdressUrl , method: .delete, headers: header).responseDecodable(of: AddUpdateDeleteAdreessModel.self){ res in
            if res.response?.statusCode == 200 {
                switch res.result{
                case .success(let user):
                    self.delegate?.deleteAddressIsDone(message: user.message!)
                case .failure(let fail):
                    self.delegate?.UpdateAdressIsFail(message: fail.localizedDescription)
                }
            }else{
                print("Not 200")
            }
        }
    }
    
    
    
    
    
    
}
