//
//  AddressModel.swift
//  LazaApp
//
//  Created by Ahmed on 25/03/2023.
//

import Foundation
struct Address: Decodable {
    let status: Bool?
    let message: String?
    let data: AddressData?
}

// MARK: - DataClass
struct AddressData: Decodable {
    let data: [AddressDetailsData]?
}

// MARK: - Datum
struct AddressDetailsData: Decodable {
    let id: Int?
    let name, city, region, details: String?
    let notes: String?
    let latitude, longitude: Double?
}
