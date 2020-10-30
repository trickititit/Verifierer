//
//  NetworkService.swift
//  Verifierer
//
//  Created by Георгий Андреев on 07.10.2020.
//

import Foundation
import Alamofire


class NetworkService {
    
//    static let BaseUrl = "http://74.208.31.66/api/v1/"
    static let BaseUrl =  "http://10.10.3.61:5555/api/v1/"
    static var user: User?
    static var shops: [BonusShop]?
    static var avatar: UIImage?
    static var history: HistoryRequest?
    static var shopID = 0
    static var product: ProductApi?
    static var product_image: UIImage?
    static var product_reviews: [Review]?
}
