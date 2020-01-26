//
//  Service.swift
//  Assignment
//
//  Created by Pankaj Wadhwa on 1/23/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

import Foundation

public enum RequestType: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
    case HEAD
}

public enum ContentType: String {
    case XML = "application/xml"
    case JSON = "application/json"
    case FORM = "application/x-www-form-urlencoded"
    case NONE = ""
}

public enum AcceptType: String {
    case XML = "application/xml"
    case JSON = "application/json"
    case HTML = "text/html"
    case TEXT = "text/plain"
    case JAVASCRIPT = "text/javascript"
    case NONE = ""
}

protocol Service {
    var baseUrl: String? { set get }
    var requestType: RequestType { get }
    var contentType: ContentType { get }
    var acceptType: AcceptType { get }
    var timeout: TimeInterval { get }
    var requestURL: String { get }
    
    var requestSerializer: RequestSerializer? { get }
    
    var requestParams: [String: AnyObject]? { get }
    var additionalHeaders: [String: String]? { get }
    var responseParser: ResponseParser? { get }
}
