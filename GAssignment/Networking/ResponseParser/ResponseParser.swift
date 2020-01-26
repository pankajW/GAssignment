//
//  ResponseParser.swift
//  SessionManager
//
//  Created by Person, Daniel on 3/27/18.
//  Copyright © 2018 U.S. Bank. All rights reserved.
//

import Foundation

public protocol ResponseParser {
    func parse(_ data: Data) -> Any?
}
