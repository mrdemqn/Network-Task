//
//  Address.swift
//  Network-Training
//
//  Created by Димон on 25.07.23.
//

import Foundation

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}
