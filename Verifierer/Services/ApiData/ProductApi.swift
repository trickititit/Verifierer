//
//  Product.swift
//  Verifierer
//
//  Created by Георгий Андреев on 28.10.2020.
//

import Foundation

struct ProductApi: Decodable {
    let id: String
    let name: String
    let price: Int
    let code: String
    let valid: Bool
    let manufacturer: String
    let brand: String
    let gost: String
    let country: String
    let sostav: String
    let category: String
    let stars: Int
    let location: String
    let description: String
    let files: [File]
  
  
}
