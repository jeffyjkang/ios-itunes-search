//
//  SearchResultsTableViewCell.swift
//  iTunesSearch
//
//  Created by Jeff Kang on 9/26/20.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ResultsCell"
    
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    
    private func updateViews() {
        guard let searchResult = searchResult else { return }
        titleLabel.text = searchResult.title
        creatorLabel.text = searchResult.creator
    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
