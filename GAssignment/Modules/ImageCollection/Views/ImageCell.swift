//
//  ImageCell.swift
//  Assignment
//
//  Created by Pankaj Wadhwa on 1/25/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell, ConfigurableCell {
    static let reuseIdentifier = "ImageCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    func configure(data: Image) {
//        ImageDownloadManager.shared.downloadImage(image: data, indexPath: IndexPath(item: 0, section: 0))
    }
}
