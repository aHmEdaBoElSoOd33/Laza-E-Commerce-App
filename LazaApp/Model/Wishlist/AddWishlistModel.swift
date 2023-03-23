//
//  AddWishlistModel.swift
//  LazaApp
//
//  Created by Ahmed on 23/03/2023.
//

import Foundation

// MARK: - Welcome
struct AddWishlistModel : Decodable {
    let status: Bool?
    let message: String?
    let data: AddWishlistModelData?
}

// MARK: - DataClass
struct AddWishlistModelData: Decodable {
    let id: Int?
    let product: AddWishlistProduct?
}

// MARK: - Product
struct AddWishlistProduct: Decodable {
    let id, price, oldPrice, discount: Int?
    let image: String?
}
