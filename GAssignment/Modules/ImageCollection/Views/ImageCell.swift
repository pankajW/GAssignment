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
    var indexPath: IndexPath?
    
    func configure(data: Image) {
        backgroundColor = .black
        activityIndicator.startAnimating()
        imageView.image = nil
        ImageDownloadManager.shared.downloadImage(data, indexPath: indexPath) { [weak self] (image, url, indexPath, error) in
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}
