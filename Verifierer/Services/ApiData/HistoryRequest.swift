//
//  HistoryRequest.swift
//  Verifierer
//
//  Created by Георгий Андреев on 27.10.2020.
//

import Foundation

struct HistoryRequest: Decodable {
    let count: Int
    let items: [History]  
}
