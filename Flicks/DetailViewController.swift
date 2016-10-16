//
//  DetailViewController.swift
//  Flicks
//
//  Created by Kyou on 10/14/16.
//  Copyright © 2016 Kyou. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    
    var data: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        
        overviewLabel.frame.size.width = scrollView.bounds.size.width - 20
        
        overviewLabel.sizeToFit()
        
        
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.size.width, height: overviewLabel.bounds.size.height + 100)
        contentView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: scrollView.contentSize)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
