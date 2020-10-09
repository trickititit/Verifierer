//
//  NetworkService.swift
//  Verifierer
//
//  Created by Георгий Андреев on 07.10.2020.
//

import Foundation
import Alamofire

class NetworkService {
    
    func getFilms() -> Void {
        let request = AF.request("https://swapi.dev/api/films")
        request.responseJSON { (data) in
            print(data)
        }
    }
    
}
