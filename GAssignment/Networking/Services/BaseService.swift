//
//  BaseService.swift
//  Assignment
//
//  Created by Pankaj Wadhwa on 1/23/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

import Foundation

class BaseService: Service {
    var baseUrl: String?

    static var baseUrl: String? {
        return "https://pixabay.com/api/?"
    }
    
    var requestType: RequestType = .GET
    var contentType: ContentType = .FORM
    var acceptType: AcceptType = .JSON
    
    var timeout: TimeInterval = 30
    var requestURL: String = ""
    
    var requestParams: [String : AnyObject]?
    var additionalHeaders: [String : String]?
    
    var responseParser: ResponseParser?
    var requestSerializer: RequestSerializer?
    
    static var apiKey: String?
    static var oauth: String?
    
    init() {
        self.requestURL = BaseService.baseUrl ?? ""
    }
}
