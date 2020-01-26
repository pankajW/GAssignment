//
//  ResponseParserJson.swift
//  SessionManager
//
//  Created by Person, Daniel on 3/27/18.
//  Copyright © 2018 U.S. Bank. All rights reserved.
//

import Foundation

class ResponseParserJson: ResponseParser {
    func parse(_ data: Data) -> Any? {
        do {
            let responseBody = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            return responseBody as Any?
        } catch let error as NSError {
            print("error parsing data: \(error.localizedDescription)")
            return nil
        }
    }
}
