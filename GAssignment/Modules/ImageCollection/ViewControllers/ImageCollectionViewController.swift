//
//  ImageCollectionViewController.swift
//  Assignment
//
//  Created by Pankaj Wadhwa on 1/24/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

import UIKit

class ImageCollectionViewController: UIViewController {

    var loadingView: LoadingReusableView?
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: ImageCell.reuseIdentifier, bundle:nil), forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
            collectionView.register(UINib(nibName: LoadingReusableView.reuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingReusableView.reuseIdentifier)

        }
    }
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    let viewModel = ImageCollectionViewModel()
    var itemsPerRow: CGFloat = 4
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Assignment"
        
        callAPIToGetImages(for: viewModel.currentPage)
    }
    
    func callAPIToGetImages(for page: Int) {
        print("current page \(page)")
        activityView.startAnimating()
        viewModel.callGetAllImages(page: page, completion: { [weak self] (success) in
            DispatchQueue.main.async {
                self?.activityView.stopAnimating()
                self?.collectionView.reloadData()
            }
        })
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
        cell?.activityIndicator.startAnimating()
        ImageDownloadManager.shared.downloadImage(viewModel.allImages?[indexPath.item], indexPath: indexPath) { (image, url, indexPath, error) in
            DispatchQueue.main.async {
                cell?.imageView.image = image
                cell?.activityIndicator.stopAnimating()
            }
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastRowIndex = collectionView.numberOfItems(inSection: 0) - 1
        if indexPath.row == lastRowIndex && !viewModel.isLoading {
            loadMoreData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingReusableView.reuseIdentifier, for: indexPath) as! LoadingReusableView
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ImageCollectionViewController: UICollectionViewDelegateFlowLayout {
    // Method to return size of each cell
    // responsible for telling the layout the size of a given cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if viewModel.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
}

//// MARK: UICollectionViewDataSourcePrefetching
extension ImageCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            ImageDownloadManager.shared.downloadImage(viewModel.allImages?[indexPath.item], indexPath: indexPath) { (_, _, _, _) in

            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let photo = viewModel.allImages?[indexPath.item] else {
                return
            }
            ImageDownloadManager.shared.slowDownImageDownloadTaskfor(photo)
        }
    }
}
extension ImageCollectionViewController {
    func loadMoreData() {
        if !viewModel.isLoading {
            viewModel.isLoading = true
            viewModel.currentPage += 1
            callAPIToGetImages(for: viewModel.currentPage)
        }
    }
}
