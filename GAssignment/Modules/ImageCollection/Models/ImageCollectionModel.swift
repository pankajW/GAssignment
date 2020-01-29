//
//  ImageCollectionModel.swift
//  Assignment
//
//  Created by Pankaj Wadhwa on 1/25/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

import Foundation
struct Response: Codable
{
    var hits: [Image]
}
struct Image: Codable {
    var id: String
    var previewURL: String?
    var largeImageURL: String?
}
