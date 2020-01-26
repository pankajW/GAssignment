//
//  RequestSerializerForm.swift
//  SessionManager
//
//  Created by Person, Daniel on 3/27/18.
//  Copyright © 2018 U.S. Bank. All rights reserved.
//

import Foundation

class RequestSerializerForm: RequestSerializer {
    var customCharacterSet: CharacterSet {
        var charSet = NSCharacterSet.urlQueryAllowed
        let remove = "+&"
        for char in remove.unicodeScalars {
            charSet.remove(char)
        }
        
        return charSet
    }
    
    func serialize(_ object: Any) -> Data? {
        var formData: Data?
        
        if let params = object as? Dictionary<String, Any> {
            var body = ""
            
            for (key, value) in params {
                let encodedKey = urlEncode(key)
                let encodedValue = urlEncode(value as! String)
                body += encodedKey+"="+encodedValue+"&"
            }
            
            body = String(body[body.startIndex..<body.endIndex])
            
            formData = body.data(using: String.Encoding.utf8)
        }
        
        return formData
    }
    
    func urlEncode(_ string: String) -> String {
        guard let encoded = string.addingPercentEncoding(withAllowedCharacters: customCharacterSet) else {
            return string
        }
        
        return encoded
    }
}
