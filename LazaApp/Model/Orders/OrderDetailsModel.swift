//
//  OrderDetailsModel.swift
//  LazaApp
//
//  Created by Ahmed on 26/03/2023.
//

import Foundation

struct OrderDetailsModel: Decodable {
    let status: Bool?
    let data: OrderDetailsModelData?
}

// MARK: - DataClass
struct OrderDetailsModelData: Decodable {
    let id, cost : Int?
    let points, discount : Double?
    let vat,total : Double?
    let points_commission: Int?
    let promo_code, payment_method, date, status: String?
    let address: OrderDetailsAddressModelData?
    let products: [OrderDetailsProductModelData]?
}

// MARK: - Address
struct OrderDetailsAddressModelData: Decodable {
    let id: Int?
    let name, city, region, details: String?
    let latitude, longitude: Double?
}

// MARK: - Product
struct OrderDetailsProductModelData: Decodable {
    let id, quantity, price: Int?
    let name: String?
    let image: String?
}
