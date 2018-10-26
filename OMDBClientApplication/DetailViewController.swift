//
//  DetailViewController.swift
//  OMDBClientApplication
//
//  Created by Mac mini on 10/26/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: CacheImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var search: Search!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let seach = search {
            setUpView(search: seach)
        }
    }
    
    func setUpView(search: Search) {
        posterImageView.loadImage(urlString: search.poster ?? "")
        titleLabel.text = search.title
        typeLabel.text = search.type
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let date = dateFormatter.date(from: search.year!)
        yearLabel.text = (date?.getElapsedInterval() ?? "") + " ago"
        
    }
    
}
