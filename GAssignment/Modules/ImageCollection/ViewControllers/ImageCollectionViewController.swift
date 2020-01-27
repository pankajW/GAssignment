//
//  ImageCollectionViewController.swift
//  Assignment
//
//  Created by Pankaj Wadhwa on 1/24/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

import UIKit

class ImageCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: ImageCell.reuseIdentifier, bundle:nil), forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        }
    }
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    let viewModel = ImageCollectionViewModel()
    var itemsPerRow: CGFloat = 4
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        activityView.startAnimating()
        viewModel.callGetAllImages { [weak self] (success) in
            print(success)
            DispatchQueue.main.async {
                self?.activityView.stopAnimating()
                self?.collectionView.reloadData()
            }
        }
    }
    
}
// MARK: - UICollectionViewDataSource
extension ImageCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell
        cell!.backgroundColor = .black
        // Configure the cell
        
        ImageDownloadManager.shared.downloadImage(viewModel.allImages?[indexPath.item], indexPath: indexPath) { (image, url, indexPath, error) in
            DispatchQueue.main.async {
                cell?.imageView.image = image
            }
        }
        
        return cell!
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ImageCollectionViewController: UICollectionViewDelegateFlowLayout {
    // Method to return size of each cell
    // responsible for telling the layout the size of a given cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // here you work out the total amount of space taken up by padding
        // there will be n + 1 evenly sized spaces, where n is the number of items in the row
        // the space size can be taken from the left section inset
        // subtracting this from the view's width and dividing by the number of items in a row gives you the width for each item
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        // return the size as a square
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // return the spacing between the cells, headers, and footers. Used a constant for that
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // controls the spacing between each line in the layout. this should be matched the padding at the left and right
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

//// MARK: UICollectionViewDataSourcePrefetching
//extension ImageCollectionViewController: UICollectionViewDataSourcePrefetching {
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            ImageDownloadManager().downloadImage(viewModel.allImages?[indexPath.item], indexPath: indexPath) { (_, _, _, _) in
//
//            }
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            guard let imageLoadOperation = imageLoadOperations[indexPath] else {
//                return
//            }
//            imageLoadOperation.cancel()
//            imageLoadOperations.removeValue(forKey: indexPath)
//
//            if Feature.debugCellLifecycle.isEnabled {
//                print(String.init(format: "cancelPrefetchingForItemsAt #%i", indexPath.row))
//            }
//        }
//    }
//}
