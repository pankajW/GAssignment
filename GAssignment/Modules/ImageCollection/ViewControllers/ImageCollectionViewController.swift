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
            collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        }
    }
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    let viewModel = ImageCollectionViewModel()
    
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = .black
        // Configure the cell
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ImageCollectionViewController: UICollectionViewDelegateFlowLayout {
    // Method to return size of each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 4
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
}
