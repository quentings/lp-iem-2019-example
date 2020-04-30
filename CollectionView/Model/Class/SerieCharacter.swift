//
//  SerieCharacter.swift
//  CollectionView
//
//  Created by Quentin Genevois on 09/01/2020.
//  Copyright © 2020 Quentin Genevois. All rights reserved.
//

import UIKit

struct SerieCharacter {
    let characterID: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let episodes: [URL]
    let url: URL
    let createdDate: Date
    let imageURL: URL
}

extension SerieCharacter: Decodable {
    enum CodingKeys: String, CodingKey {
        case characterID = "id"
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case episodes = "episode"
        case url
        case imageURL = "image"
        case createdDate = "created"
    }
}
