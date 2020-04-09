//
//  ViewController.swift
//  imageRequest
//
//  Created by user on 09.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum KittenImageLocation: String {
        case http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
        case https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
        case error = "not a url"
    }
    
    let imageLocation = KittenImageLocation.http.rawValue
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func loadButtonPressed(_ sender: UIButton) {
        guard let imageUrl = URL(string: imageLocation) else {
            print ("Cannot create URL")
            return
        }
        
        //        let task = URLSession.shared.dataTask(with: imageUrl, completionHandler: {(data, response, error)
        //            in
        //            guard let data = data else {
        //                print ("No data")
        //                return
        //            }
        //
        //            let downloadedImage = UIImage(data:data)
        //
        //            DispatchQueue.main.async {
        //                self.imageView.image = downloadedImage
        //            }
        //        })
        //
        //        task.resume()
        
        let task = URLSession.shared.downloadTask(with: imageUrl) {
            (location, response, error)
            in
            guard let location = location else {
                print ("no location")
                return
            }
            
            let imageData = try! Data(contentsOf: location)
            let image = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

