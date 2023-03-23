//
//  ProductDetailsModel.swift
//  LazaApp
//
//  Created by Ahmed on 22/03/2023.
//

import Foundation
 
struct ProductDetails: Decodable {
    let data: ProductDetailsInfo?
}

 
struct ProductDetailsInfo: Decodable {
    let id, price, oldPrice, discount: Int?
    let image: String?
    let name, description: String?
    let inFavorites, inCart: Bool?
    let images: [String]?
}
