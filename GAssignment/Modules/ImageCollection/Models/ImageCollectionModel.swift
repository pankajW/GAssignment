//
//  ImageCollectionModel.swift
//  Assignment
//
//  Created by Pankaj Wadhwa on 1/25/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

import Foundation
struct Image: Codable {
    var urls: URLS
    var id: String
}
struct URLS: Codable {
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?
}

