//
//  LoadingCollectionViewCell.swift
//  OMDBClientApplication
//
//  Created by Mac mini on 10/10/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import UIKit

class LoadingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
    }
    

}
