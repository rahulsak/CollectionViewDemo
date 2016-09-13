//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by iRaul on 3/11/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit

    let APIKey = "testAPIKey"
    let baseURL = "https://api.com/v1/"
    
    class ViewController: UICollectionViewController {
        
        var itemList = [DataModel]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
            layout.estimatedItemSize = CGSize(width: 150,height: 40)
            
            NetworkService.getItems { [weak weakSelf = self](items) in
                weakSelf?.itemList = items
                weakSelf?.collectionView?.reloadData()
            }

        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        override func collectionView(collectionView: UICollectionView,
                                     numberOfItemsInSection section: Int) -> Int {
            return itemList.count
        }
        
        override func collectionView(collectionView: UICollectionView,cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
            let newCell = collectionView
                .dequeueReusableCellWithReuseIdentifier("Cell",forIndexPath: indexPath) as! CustomCollectionView
            newCell.lblName.text = itemList[indexPath.row].name
            NetworkService.fetchImage(itemList[indexPath.row].imageURL){ image in
                newCell.imgThumbnail.image = image
            }
            return newCell
        }
        
    }
    
    
    




