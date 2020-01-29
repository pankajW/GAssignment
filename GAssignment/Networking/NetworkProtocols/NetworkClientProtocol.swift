//
//  NetworkClientProtocol.swift
//  GAssignment
//
//  Created by Pankaj Wadhwa on 1/23/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case incorrectData(Data)
    case incorrectURL
    case parsingError
    case noDataReturned
    case unknownContentType
    case unknown
}

typealias ServiceResponseObject = (Result<Any, Error>) -> Void

protocol NetworkClientProtocol {

    /// Initiate a service call
    ///
    /// - Parameters:
    ///   - service: service endpoint to call of protocol `Service`
    ///   - serviceResponse: `(Result<Any, Error>) -> Void` defined closure
    @discardableResult
    func callService(_ service: Service, withCallback serviceResponse: @escaping ServiceResponseObject) -> URLSessionDataTask?
}
