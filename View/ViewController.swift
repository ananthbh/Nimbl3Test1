//
//  ViewController.swift
//  View
//
//  Created by Ananth Bhamidipati on 11/08/16.
//  Copyright © 2016 Ananth Bhamidipati. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    let screenSize:CGSize = UIScreen.mainScreen().bounds.size
    let NavHei = 30
    
    var JSON = Data.sharedInstance
    
    @IBOutlet var collectionview: UICollectionView!
    
    @IBOutlet var pageControl: UIPageControl!
    
    @IBAction func PagevalueChanged(sender: AnyObject) {
       collectionview.setContentOffset(CGPointMake(0, (screenSize.height-CGFloat(NavHei)) * CGFloat(pageControl.currentPage)), animated: true)
    }
    
    @IBAction func Refresh(sender: AnyObject) {
        self.JSON.JsonData{
            self.pageControl.numberOfPages = self.JSON.arrSurvey.count
            self.collectionview.reloadData()
            self.collectionview.setContentOffset(CGPointZero, animated: true)
            SVProgressHUD.dismiss()
        }
    }
    
    @IBOutlet var takeSurvey: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet is connected")
        } else {
            print("Internet connection failed")
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the Internet", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }

        takeSurvey.layer.cornerRadius = 15
        takeSurvey.layer.borderWidth = 1
        takeSurvey.hidden = true
    
        pageControl.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        pageControl.hidden = true
        
        self.JSON.JsonData{
            self.pageControl.numberOfPages = self.JSON.arrSurvey.count
            self.collectionview.reloadData()
            self.takeSurvey.hidden = false
            self.pageControl.hidden = false
            SVProgressHUD.dismiss()
        }
    }
 
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(screenSize.width, screenSize.height - CGFloat(NavHei))
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.JSON.arrSurvey.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.NameLabel.text = self.JSON.arrSurvey[indexPath.row].naame
        cell.DescLabel.text = self.JSON.arrSurvey[indexPath.row].description
        cell.coverimage.kf_setImageWithURL(NSURL(string: self.JSON.arrSurvey[indexPath.row].images))
        pageControl.currentPage = indexPath.row

        return cell
    }

}

