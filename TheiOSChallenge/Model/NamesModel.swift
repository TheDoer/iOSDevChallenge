//
//  NamesModel.swift
//  TheiOSChallenge
//
//  Created by Adonis Rumbwere on 19/7/2021.
//

import Foundation

// MARK: - PurpleData
struct PurpleData: Codable {
    var data: [Datum]?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

// MARK: - Datum
struct Datum: Codable {
    var name: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}
