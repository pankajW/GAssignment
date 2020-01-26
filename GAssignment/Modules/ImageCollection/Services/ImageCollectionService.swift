//
//  ImageCollectionService.swift
//  Assignment
//
//  Created by Pankaj Wadhwa on 1/25/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

class ImageCollectionService: BaseService {
    override init() {
        super.init()
        self.requestURL += "photos/?"
        self.responseParser = GenericParser<[Image]>()
        
        self.requestParams = [ImageCollectionConstants.strClientId: ImageCollectionConstants.clientId, ImageCollectionConstants.page: "1", ImageCollectionConstants.perPage: "20"] as [String: AnyObject]
    }
}
