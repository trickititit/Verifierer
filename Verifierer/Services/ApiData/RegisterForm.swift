//
//  RegisterForm.swift
//  Verifierer
//
//  Created by Георгий Андреев on 28.10.2020.
//

import Foundation

struct RegisterForm: Encodable {
    let email: String
    let name: String
    let genderId: Int
    let bod: String
    let password: String
    let phone: String
}
