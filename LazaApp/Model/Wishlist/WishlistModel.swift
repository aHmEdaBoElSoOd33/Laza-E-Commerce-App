//
//  WishlistModel.swift
//  LazaApp
//
//  Created by Ahmed on 22/03/2023.
//

import Foundation


struct Wishlist: Decodable {
    let status: Bool? 
    let data: WishlistDataClass?
}

// MARK: - DataClass
struct WishlistDataClass: Decodable {
    let data: [WishlistData]?
}

// MARK: - Datum
struct WishlistData: Decodable {
    let id: Int?
    let product: WishlistProduct?
}

// MARK: - Product
struct WishlistProduct: Decodable {
    let id: Int?
    let price, oldPrice: Double?
    let discount: Int?
    let image: String?
    let name, description: String? 
}
 
