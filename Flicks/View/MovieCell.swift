//
//  MovieCell.swift
//  Flicks
//
//  Created by Kyou on 10/12/16.
//  Copyright © 2016 Kyou. All rights reserved.
//

import UIKit
import AFNetworking

class MovieCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    var data: Movie?{
        didSet{
            let posterUrl = "\(data!.originalPath)\(data!.imagePath)"
            posterImageView.setImageWith(URL(string: posterUrl)!, placeholderImage: UIImage(named: "movie_placeholder"))
            titleLabel.text = data?.name
            overviewLabel.text = data?.overview

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
