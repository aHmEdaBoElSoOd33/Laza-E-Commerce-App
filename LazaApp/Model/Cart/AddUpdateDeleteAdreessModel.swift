//
//  AddUpdateDeleteAdreessModel.swift
//  LazaApp
//
//  Created by Ahmed on 25/03/2023.
//

import Foundation

struct AddUpdateDeleteAdreessModel: Decodable {
    let status: Bool?
    let message: String?
    let data: AddUpdateDeleteAdreessModelData?
}

// MARK: - DataClass
struct AddUpdateDeleteAdreessModelData: Decodable {
    let name, city, region, details: String?
    let latitude, longitude: Double?
    let notes: String?
    let id: Int?
}
