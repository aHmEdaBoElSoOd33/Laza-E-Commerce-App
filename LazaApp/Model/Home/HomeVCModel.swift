//
//  HomeVCModel.swift
//  LazaApp
//
//  Created by Ahmed on 21/03/2023.
//

import Foundation
  
    struct HomeVCModel: Decodable {
        let status: Bool?
        let data: HomeDataClass?
    }

    // MARK: - DataClass
    struct HomeDataClass: Decodable {
         
        let products: [Product]?
        
    }
  
    // MARK: - Product
    struct Product: Decodable {
        let id: Int?
        let price, oldPrice: Double?
        let discount: Int?
        let image: String?
        let name, description: String?
        let images: [String]?
        let in_favorites, in_cart: Bool?
    }
    
    
     
