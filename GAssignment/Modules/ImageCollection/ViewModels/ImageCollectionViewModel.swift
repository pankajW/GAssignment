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
    var currentPage: Int = 0
    
    func numberOfRowsInSection(section: Int) -> Int {
        return allImages?.count ?? 0
    }
    
    func callGetAllImages(page: Int = 0,  completion: @escaping ParsedResponse) {
        
        ImageCollectionWorker.getAllImages(page: page) { [weak self] result in
            switch result {
            case .success(let data):
                
                if var allImages = self?.allImages, page > 1  {
                    allImages += (data as? Response)?.hits ?? []
                    self?.allImages = allImages
                } else {
                    self?.allImages = (data as? Response)?.hits
                }
                
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
            
        }
    }
}
