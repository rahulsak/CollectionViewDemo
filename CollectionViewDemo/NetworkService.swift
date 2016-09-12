//
//  NetworkService.swift
//  CollectionViewDemo
//
//  Created by iRaul on 3/11/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import Foundation
import UIKit

class NetworkService {
    
    //get the items [name, thumbnail image]
    static func getItems(completion:([DataModel])->()) {
        let url = NSURL(string: baseURL+"?apiKey=\(APIKey)")!
        let task = NSURLSession.sharedSession()
            .dataTaskWithURL(url) { (data, response, error) in
                guard error == nil else {
                    return print("Error: \(error!.localizedDescription)")
                }
                guard let data = data else {
                    return print("Data is empty!")
                }
                guard let json = try! NSJSONSerialization
                    .JSONObjectWithData(data, options: []) as? NSDictionary else {
                        return print("Not a Dictionary")
                }
                guard let items = json["items"] as? NSArray else {
                    return print("Items not found")
                }
                
                var newItems = [DataModel]()
                for thing in items {
                    guard let newItem = DataModel(json: thing) else {
                        continue
                    }
                    newItems.append(newItem)
                }
            // pass the data and update UI
            dispatch_async(dispatch_get_main_queue(), {
                completion(newItems)
            })
        }
        task.resume()
    }
    
    //get image from url
    static func fetchImage(imageURL:String, completion: (image: UIImage?) -> ()) {
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string:imageURL)!) {
            (data, response, error) in
            let image = UIImage(data:data!)
            dispatch_async(dispatch_get_main_queue()){
                completion(image: image)
            }
        }
        task.resume()
    }
}