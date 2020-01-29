//
//  ImageCollectionViewModel.swift
//  Assignment
//
//  Created by Pankaj Wadhwa on 1/25/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

import Foundation

class ImageCollectionViewModel: NSObject {
    
    typealias ParsedResponse = (Bool)-> Void
    var allImages: [Image]?
    var isLoading = false
    var currentPage: Int = 1
    
    func numberOfRowsInSection(section: Int) -> Int {
        return allImages?.count ?? 0
    }
    
    func callGetAllImages(page: Int = 1,  completion: @escaping ParsedResponse) {
        
        ImageCollectionWorker.getAllImages(page: page) { [weak self] result in
            switch result {
            case .success(let data):
                self?.allImages = (data as? Response)?.hits as? [Image]
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
            
        }
    }
}
