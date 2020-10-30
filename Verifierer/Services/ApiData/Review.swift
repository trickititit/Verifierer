//
//  Review.swift
//  Verifierer
//
//  Created by Георгий Андреев on 29.10.2020.
//

import Foundation

struct Review: Decodable {
    let id: String
    let creationDate: String
    let stars: Int
    let description: String
    let reviewFiles: [File]
    let user: UserReview
}
