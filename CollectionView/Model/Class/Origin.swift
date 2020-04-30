//
//  Origin.swift
//  CollectionView
//
//  Created by Quentin Genevois on 09/01/2020.
//  Copyright © 2020 Quentin Genevois. All rights reserved.
//

import Foundation

struct Origin {
    let name: String
    private let urlString: String

    var url: URL? {
        URL(string: urlString)
    }
}

extension Origin: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case urlString = "url"
    }
}
