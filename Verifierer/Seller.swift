//
//  Seller.swift
//  Verifierer
//
//  Created by Георгий Андреев on 09.10.2020.
//

import Foundation
import UIKit

class Seller {
    let id: Int
    let name: String
    let color: UIColor
    let bonusCount: Int
    
    init(id: Int, name: String, color: UIColor, bonusCount: Int) {
        self.id = id
        self.name = name
        self.color = color
        self.bonusCount = bonusCount
    }
}
