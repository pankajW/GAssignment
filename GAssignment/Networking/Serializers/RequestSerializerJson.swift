//
//  RequestSerializerJson.swift
//  SessionManager
//
//  Created by Person, Daniel on 3/27/18.
//  Copyright © 2018 U.S. Bank. All rights reserved.
//

import Foundation

open class RequestSerializerJson: RequestSerializer {
    open func serialize(_ object: Any) -> Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.prettyPrinted)
            return jsonData
        } catch let error as NSError {
            print("error serializing JsON string: \(error.localizedDescription)")
            return nil
        }
    }
}
