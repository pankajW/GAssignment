//
//  ImageCollectionService.swift
//  Assignment
//
//  Created by Pankaj Wadhwa on 1/25/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

class ImageCollectionService: BaseService {
    init(page: Int) {
        super.init()
        self.responseParser = GenericParser<Response>()
        self.requestParams = [ImageCollectionConstants.key: ImageCollectionConstants.clientId, ImageCollectionConstants.page: "\(page+1)", ImageCollectionConstants.perPage: "\(50)", ImageCollectionConstants.image_type: ImageCollectionConstants.photo, ImageCollectionConstants.pretty: "true"] as [String: AnyObject]
    }
}
