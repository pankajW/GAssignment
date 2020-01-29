//
//  RequestSerializerJson.swift
//  GAssignment
//
//  Created by Pankaj Wadhwa on 1/25/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

import Foundation

class RequestSerializerJson: RequestSerializer {
    func serialize(_ object: Any) -> Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.prettyPrinted)
            return jsonData
        } catch let error as NSError {
            print("error serializing JsON string: \(error.localizedDescription)")
            return nil
        }
    }
}
