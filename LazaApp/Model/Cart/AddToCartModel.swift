//
//  AddToCartModel.swift
//  LazaApp
//
//  Created by Ahmed on 24/03/2023.
//

import Foundation


// MARK: - Welcome
struct AddToCartModel: Decodable {
    let status: Bool?
    let message: String?
    let data: AddToCartDataModel?
}
// MARK: - DataClass
struct AddToCartDataModel: Decodable {
    let id, quantity: Int?
    let product: AddToCartProduct?
}

// MARK: - Product
struct AddToCartProduct: Decodable {
    let id: Int?
    let price, oldPrice: Double?
    let discount: Int?
    let image: String?
    let name, description: String?
}
