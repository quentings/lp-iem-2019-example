//
//  PaginationInformation.swift
//  CollectionView
//
//  Created by Quentin Genevois on 14/01/2020.
//  Copyright © 2020 Quentin Genevois. All rights reserved.
//

import Foundation

struct PaginationInformation {
    let count: Int
    let pages: Int
    private let nextURLString: String
    private let previousURLString: String

    var nextURL: URL? {
        URL(string: nextURLString)
    }

    var previousURL: URL? {
        URL(string: previousURLString)
    }
}

extension PaginationInformation: Decodable {
    enum CodingKeys: String, CodingKey {
        case count
        case pages
        case nextURLString = "next"
        case previousURLString = "prev"
    }
}


struct PaginatedElements<T: Decodable> {
    let information: PaginationInformation
    let decodedElement: [T]
}

extension PaginatedElements: Decodable {
    enum CodingKeys: String, CodingKey {
        case information = "info"
        case decodedElement = "results"
    }
}

