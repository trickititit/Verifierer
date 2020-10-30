//
//  History.swift
//  Verifierer
//
//  Created by Георгий Андреев on 27.10.2020.
//

import Foundation
	
struct History: Decodable {
    let id: String
    let shopId: Int
    let scannedAt: String
    let addedValue: Int
    let shopName: String
}
