//
//  CollectionViewCell.swift
//  OMDBClientApplication
//
//  Created by Mac mini on 10/9/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: CacheImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    func setUpView(search: Search) {
        posterImageView.image = nil
        posterImageView.loadImage(urlString: search.poster ?? "") 
        titleLabel.text = search.title
        typeLabel.text = search.type
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let date = dateFormatter.date(from: search.year!)
        yearLabel.text = (date?.getElapsedInterval() ?? "") + " ago"
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

// MARK: - Helpers

extension Date {
    func getElapsedInterval() -> String {
        
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Bundle.main.preferredLocalizations[0])
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1
        formatter.calendar = calendar
        
        var dateString: String?
        
        let interval = calendar.dateComponents([.year, .month, .weekOfYear, .day], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            formatter.allowedUnits = [.year]
        } else if let month = interval.month, month > 0 {
            formatter.allowedUnits = [.month]
        } else if let week = interval.weekOfYear, week > 0 {
            formatter.allowedUnits = [.weekOfMonth]
        } else if let day = interval.day, day > 0 {
            formatter.allowedUnits = [.day]
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: Bundle.main.preferredLocalizations[0])
            dateFormatter.dateStyle = .medium
            dateFormatter.doesRelativeDateFormatting = true
            
            dateString = dateFormatter.string(from: self)
        }
        
        if dateString == nil {
            dateString = formatter.string(from: self, to: Date())
        }
        
        return dateString!
    }
}
