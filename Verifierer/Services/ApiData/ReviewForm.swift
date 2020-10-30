//
//  ReviewForm.swift
//  Verifierer
//
//  Created by Георгий Андреев on 28.10.2020.
//

import Foundation

struct ReviewForm: Encodable {
    let productId: String
    let bonusShopId: Int
    let review: String
    let stars: Int
    let photo: String
}
