//
//  ImageDownloadManager.swift
//  Assignment
//
//  Created by Pankaj Wadhwa on 1/26/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

import UIKit

typealias ImageDownloadHandler = (_ image: UIImage?, _ url: URL, _ indexPath: IndexPath?, _ error: Error?) -> Void
class ImageDownloadManager {
    
    static let shared = ImageDownloadManager()
    private init() {}
    
    lazy var imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.assignment.imageDownloadqueue"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    func downloadImage(image: Image, indexPath: IndexPath, handler: @escaping ImageDownloadHandler) {
        /* check if there is already a task to downlad this same image. */
    }
    
}
