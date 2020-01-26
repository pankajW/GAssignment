//
//  ImageCollectionWorker.swift
//  Assignment
//
//  Created by Pankaj Wadhwa on 1/25/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

class ImageCollectionWorker {
        
    static func getAllImages(callBack: @escaping ServiceResponseObject) {
        APIClient.sharedInstance.callService(ImageCollectionService(), withCallback: callBack)
    }
}
