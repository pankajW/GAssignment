//
//  Data+Extensions.swift
//  Assignment
//
//  Created by Pankaj Wadhwa on 1/25/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

import Foundation

// Used for data decode
extension Data {
    func decode<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
