//
//  ViewController.swift
//  Flicks
//
//  Created by Kyou on 10/12/16.
//  Copyright © 2016 Kyou. All rights reserved.
//

import UIKit
import SVProgressHUD

class PlayingViewController: UIViewController {
    
    var movies = [Movie]()
    let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
    var refreshControl = UIRefreshControl()
    let errorAlertView = UIAlertController(title: "Error", message: "Check your network connection", preferredStyle: .alert)
    
    @IBOutlet weak var movieTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        errorAlertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        movieTableView.isHidden = true
        SVProgressHUD.show()
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        movieTableView.insertSubview(refreshControl, at: 0)
        
        if let url = url {
            let request = URLRequest(
                url: url,
                cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
                timeoutInterval: 10)
            
            let session = URLSession(
                configuration: URLSessionConfiguration.default,
                delegate: nil,
                delegateQueue: OperationQueue.main)
            
            let task = session.dataTask(
                with: request,
                completionHandler: { (dataOrNil, response, error) in
                    
                    SVProgressHUD.dismiss()
                    self.movieTableView.isHidden = false
                    
                    guard error == nil else {
                        self.present(self.errorAlertView, animated: true, completion: nil)
                        return
                    }
                    
                    
                    if let data = dataOrNil {
                        if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                            //                            print("response: \(responseDictionary)")
                            
                            
                            
                            if let movieData = responseDictionary["results"] as? [[String: AnyObject]] {
                                
                                for movie in movieData {
                                    self.movies.append(Movie(dict: movie))
                                    self.movieTableView.reloadData()
                                }
                                
                            }
                        }
                    }
                    
            })
            task.resume()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        
        let data = movies[(movieTableView.indexPathForSelectedRow?.row)!]
        
        detailVC.data = data
    }
    
    func pullToRefresh(refreshControl: UIRefreshControl){
        
        movies.removeAll()
        
        if let url = url {
            let request = URLRequest(
                url: url,
                cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
                timeoutInterval: 10)
            
            let session = URLSession(
                configuration: URLSessionConfiguration.default,
                delegate: nil,
                delegateQueue: OperationQueue.main)
            
            let task = session.dataTask(
                with: request,
                completionHandler: { (dataOrNil, response, error) in

                    self.refreshControl.endRefreshing()
                    self.movieTableView.isHidden = false
                    
                    guard error == nil else {
                        self.present(self.errorAlertView, animated: true, completion: nil)
                        return
                    }
                    
                    if let data = dataOrNil {
                        if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {

                            if let movieData = responseDictionary["results"] as? [[String: AnyObject]] {
                                
                                for movie in movieData {
                                    self.movies.append(Movie(dict: movie))
                                    self.movieTableView.reloadData()
                                }
                                
                            }
                        }
                    }
                    
            })
            task.resume()
        }
    }
    
}


extension PlayingViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieCell
        movieCell.data = movies[indexPath.row]
        return movieCell
    }
}
