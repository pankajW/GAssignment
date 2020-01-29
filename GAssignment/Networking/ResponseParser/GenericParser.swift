//
//  GenericParser.swift
//  GAssignment
//
//  Created by Pankaj Wadhwa on 1/25/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//
import Foundation
class GenericParser<T: Decodable>: ResponseParser {
    
    func parse(_ data: Data) -> Any? {
        print(dataToJSON(data: data)!)
        do {
            let decodeData = try data.decode() as T
            return decodeData
        } catch let error as NSError {
            print("error parsing data: \(error.localizedDescription)")
            return nil
        }
    }
    
    func dataToJSON(data: Data) -> AnyObject? { // For debugging purpose only
           do {
               return try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as AnyObject
           } catch let myJSONError {
               print("Error in Serializing JSON: \(myJSONError)")
           }
           return nil
       }
}
