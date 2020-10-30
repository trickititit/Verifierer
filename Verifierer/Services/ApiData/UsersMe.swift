//
//  UsersMe.swift
//  Verifierer
//
//  Created by Георгий Андреев on 26.10.2020.
//

import Foundation

struct User: Decodable {
    let id: String
  let userName: String
    let sex: String
    let firstName: String
    let bod: String
    let bonusesSummary: Int
  let bonuses: [Bonus]
}
