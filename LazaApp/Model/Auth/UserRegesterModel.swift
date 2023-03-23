//
//  UserRegesterModel.swift
//  LazaApp
//
//  Created by Ahmed on 20/03/2023.
//

import Foundation

// MARK: - Welcome
struct UserRegisterModel: Decodable {
    let status: Bool?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Decodable {
    let name, phone, email: String?
    let id: Int?
    let image: String?
    let token: String?
}
