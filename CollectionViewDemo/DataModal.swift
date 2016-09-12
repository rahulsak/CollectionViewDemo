//
//  DataModal.swift
//  CollectionViewDemo
//
//  Created by iRaul on 2/11/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import Foundation

struct DataModel {
    var name: String
    var imageURL: String
    
    init?(json: AnyObject) {
        guard let itemList = json as? NSDictionary else {
            return nil
        }
        guard let name = itemList["name"] as? String,
              let image = itemList["thumbnailImage"] as? String else {
                return nil
        }
        self.name = name
        self.imageURL = image
    }
}

