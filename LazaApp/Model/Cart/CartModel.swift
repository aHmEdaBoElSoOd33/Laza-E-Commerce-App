//
//  CartModel.swift
//  LazaApp
//
//  Created by Ahmed on 23/03/2023.
//

import Foundation

struct Cart : Decodable {
    let status: Bool?
    let data: CartData?
}

// MARK: - DataClass
struct CartData: Decodable {
    let cart_items: [CartItem]?
    let sub_total, total: Double?
}

// MARK: - CartItem
struct CartItem: Decodable {
    let id, quantity: Int?
    let product: CartProduct?
}

// MARK: - Product
struct CartProduct: Decodable {
    let id: Int?
    let price, oldPrice: Double?
    let discount: Int?
    let image: String?
    let name, description: String?
    let images: [String]?
    let in_favorites, in_cart: Bool?
}
