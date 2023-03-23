//
//  categoriyModel.swift
//  LazaApp
//
//  Created by Ahmed on 21/03/2023.
//

import Foundation


struct AllCategories : Decodable {
    let status: Bool?
    let data : Category?
}


struct Category : Decodable {
    let data: [Datum]? 
}

struct Datum : Decodable {
    let id: Int?
    let name: String?
    let image: String?
}

 
