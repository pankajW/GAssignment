//
//  ResponseParserJson.swift
//  GAssignment
//
//  Created by Pankaj Wadhwa on 1/25/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
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
