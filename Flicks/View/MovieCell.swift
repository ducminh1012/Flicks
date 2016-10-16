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
            let lowUrl = "\(data!.lowPath)\(data!.imagePath)"
            
            
            let highRequest = URLRequest(url: URL(string: posterUrl)!)
            let lowRequest = URLRequest(url: URL(string: lowUrl)!)
            
            posterImageView.setImageWith(lowRequest, placeholderImage: nil, success: { (imageRequest, imageRespone, image) in
                
                self.posterImageView.alpha = 0.0
                self.posterImageView.image = image
                
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    
                    self.posterImageView.alpha = 1.0
                    
                    }, completion: { (sucess) -> Void in
                        
                        // The AFNetworking ImageView Category only allows one request to be sent at a time
                        // per ImageView. This code must be in the completion block.
                        self.posterImageView.setImageWith(
                            highRequest,
                            placeholderImage: image,
                            success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
                                
                                self.posterImageView.image = largeImage
                                
                            },
                            failure: { (request, response, error) -> Void in
                                // do something for the failure condition of the large image request
                                // possibly setting the ImageView's image to a default image
                        })
                })
                
                
            }) { (imageRequest, imageRespone, error) in
                print(error)
            }
            
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
