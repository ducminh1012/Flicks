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
        
        posterImageView.setImageWith(URL(string: posterUrl)!, placeholderImage: UIImage(named: "movie_placeholder"))
        
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
