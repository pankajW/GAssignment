//
//  RequestSerializer.swift
//  GAssignment
//
//  Created by Pankaj Wadhwa on 1/25/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

import Foundation

protocol RequestSerializer {
    func serialize(_ object: Any) -> Data?
}
