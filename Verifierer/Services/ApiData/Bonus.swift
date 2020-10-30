//
//  Bonus.swift
//  Verifierer
//
//  Created by Георгий Андреев on 26.10.2020.
//

import Foundation

struct Bonus: Decodable {
    let id: String
    let appliedTo: String
    let value: Int
  let bonusShop: BonusShop
  
}
