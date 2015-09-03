//
//  HomeViewController.swift
//  Interests
//
//  Created by David on 2015/8/24.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var currentUserProfileImageButton: UIButton!
    @IBOutlet weak var currentUserFullNameButton: UIButton!
    
    // MARK: - collection view data source
    private var interests = Interest.createInterests()
    private var slideRightTransitionAnimator = SlideRightTransitionAnimator()
    private var popTransitionAnimator = PopTransitionAnimator()
    
    // MAKR: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if UIScreen.mainScreen().bounds.size.height == 480.0 {
            // iphone 4s
            let flowlayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            flowlayout.itemSize = CGSize(width: 250.0, height: 300.0)
        }
        
        configureUserProfile()
    }
    
    func configureUserProfile() {
        currentUserProfileImageButton.contentMode = UIViewContentMode.ScaleAspectFill
        currentUserProfileImageButton.clipsToBounds = true
        currentUserProfileImageButton.layer.cornerRadius = currentUserProfileImageButton.bounds.width / 2
    }
    
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    private struct Storyboard {
        static let CellIdentifier = "Interest Cell"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show Interest" {
            let cell = sender as! InterestCollectionViewCell
            let interest = cell.interest
            
            let navigationViewController = segue.destinationViewController as! UINavigationController
            navigationViewController.transitioningDelegate = popTransitionAnimator
            let interestViewController = navigationViewController.topViewController as! InterestViewController
            
            interestViewController.interest = interest
        } else if segue.identifier == "CreateNewInterest" {
            let newInterestViewController = segue.destinationViewController as! NewInterestViewController
            newInterestViewController.transitioningDelegate = slideRightTransitionAnimator
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! InterestCollectionViewCell
        cell.interest = self.interests[indexPath.item]
        
        return cell
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.memory
        print(scrollView.contentInset.top)
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.memory = offset
    }
}
