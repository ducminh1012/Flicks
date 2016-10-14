//
//  Movie.swift
//  Flicks
//
//  Created by Kyou on 10/12/16.
//  Copyright © 2016 Kyou. All rights reserved.
//

import UIKit

class Movie: NSObject {
    
    var id = 0
    var name = ""
    var overview = ""
    var imagePath = ""
    
    let originalPath = "https://image.tmdb.org/t/p/original"
    let lowPath = "https://image.tmdb.org/t/p/w45"
    
    init(dict: [String: AnyObject]) {
        id = dict["id"] as? Int ?? 0
        name = dict["title"] as? String ?? ""
        overview = dict["overview"] as? String ?? ""
        imagePath = dict["poster_path"] as? String ?? ""
    }
}
