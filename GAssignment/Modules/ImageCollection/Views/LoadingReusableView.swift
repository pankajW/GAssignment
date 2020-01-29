//
//  LoadingReusableView.swift
//  GAssignment
//
//  Created by Pankaj Wadhwa on 1/29/20.
//  Copyright © 2020 Pankaj Wadhwa. All rights reserved.
//

import UIKit

class LoadingReusableView: UICollectionReusableView {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    static let reuseIdentifier = "LoadingReusableView"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
