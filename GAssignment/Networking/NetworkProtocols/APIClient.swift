//
//  APIClient.swift
//  Assignment
//
//  Created by Pankaj Wadhwa on 1/23/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

import Foundation

class APIClient: NetworkClientProtocol {
    
    static let sharedInstance = APIClient()
    private init() {}
    
    func callService(_ service: Service, withCallback serviceResponse: @escaping ServiceResponseObject) -> URLSessionDataTask? {
        let request = createRequest(service)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                serviceResponse(.failure(error ?? NetworkError.unknown))
                return
            }
           
            if let urlResponse = response as? HTTPURLResponse {
                if let headers = urlResponse.allHeaderFields as? [String: AnyObject] {
                    if let contentTypeHeader = headers["Content-Type"] as? String {
                        let contentType = self.getContentType(contentTypeHeader: contentTypeHeader)
                        
                        let acceptType = self.getAcceptType(service: service)
                        if acceptType == contentType {
                                if let parser = service.responseParser // CUSTOM PARSER
                                {
                                    if let parsedData = parser.parse(data) {
                                        switch parsedData {
                                        case is NSError:
                                            serviceResponse(.failure(error ?? NetworkError.unknown))
                                        default:
                                            serviceResponse(.success(parsedData))
                                        }
                                    } else {
                                        serviceResponse(.failure(error ?? NetworkError.parsingError))
                                    }
                                } else // USE DEFAULT PARSERS
                                {
                                    switch service.acceptType {
                                    case .JSON:
                                        if let parsedData = ResponseParserJson().parse(data) {
                                            serviceResponse(.success(parsedData))
                                        } else {
                                            serviceResponse(.failure(error ?? NetworkError.parsingError))
                                        }
                                    case .HTML, .TEXT:
                                        if let text = String(data: data, encoding: String.Encoding.utf8) {
                                            serviceResponse(.success(text))
                                        } else if let text = String(data: data, encoding: String.Encoding.ascii) {
                                            serviceResponse(.success(text))
                                        } else {
                                           serviceResponse(.failure(error ?? NetworkError.parsingError))
                                        }
                                    case .XML:
                                        let parsedData = XMLParser(data: data)
                                        serviceResponse(.success(parsedData))
                                    default:
                                        serviceResponse(.failure(error ?? NetworkError.unknownContentType))
                                    }
                                }
                        } else {
                                 serviceResponse(.failure(error ?? NetworkError.unknownContentType))
                        }
                    } else {
                             serviceResponse(.failure(error ?? NetworkError.unknownContentType))
                    }
                }
            } else {
                    serviceResponse(.failure(error ?? NetworkError.noDataReturned))
            }
        }
        
        task.resume()
        return task
    }
    
    // MARK: HELPER METHODS
    
    fileprivate func createRequest(_ service: Service) -> URLRequest {
        let request = NSMutableURLRequest()

        // do not cache (store) request responses in cache.db (on disk)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.url = URL(string: service.requestURL)
        request.httpMethod = service.requestType.rawValue
        request.timeoutInterval = service.timeout
        
        if let additionalHeaders = service.additionalHeaders {
            for (key, value) in additionalHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        

        if service.contentType.rawValue != "" {
            request.setValue(service.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        }

        if service.acceptType.rawValue != "" {
            request.setValue(service.acceptType.rawValue, forHTTPHeaderField: "Accept")
        }
        
        guard let requestParams = service.requestParams else {
            return request as URLRequest
        }
        
        if requestParams.count > 0 {
            if let serializer = service.requestSerializer // IF THE SERVICE HAS A CUSTOM SERIALIZER
            {
                if let data = serializer.serialize(requestParams as Any) {
                    request.httpBody = data
                }
            } else {
                switch service.contentType // USE DEFAULT SERIALIZERS
                {
                case.JSON:
                    if let data = RequestSerializerJson().serialize(requestParams as Any) {
                        request.httpBody = data
                    }
                case.FORM:
                    if let data = RequestSerializerForm().serialize(requestParams as Any) {
                        if service.requestType == .GET {
                            if let vars = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? {
                                request.url = URL(string: service.requestURL+"?"+vars)
                            }
                        } else {
                            request.httpBody = data
                        }
                    }
                case.XML:break // TODO: HANDLE XML BODY
                case.NONE:break
                }
            }
        }
        
        return request as URLRequest
    }
    
    fileprivate func getContentType(contentTypeHeader: String) -> String {
        var contentType = contentTypeHeader
        let contentTypeArray = contentTypeHeader.components(separatedBy: ";")
        if contentTypeArray.count > 0 {
            contentType = contentTypeArray[0]
        }
        
        return contentType
    }
    
    fileprivate func getAcceptType(service: Service) -> String {
        let acceptType = service.acceptType.rawValue
        return acceptType
    }
}
