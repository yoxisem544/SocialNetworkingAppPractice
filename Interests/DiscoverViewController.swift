//
//  DiscoverViewController.swift
//  Interests
//
//  Created by David on 2015/9/4.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var searchBarInputAccessoryView: UIView!
    
    private var searchText: String! {
        didSet {
            searchInterestsForKey(searchText)
        }
    }
    
    func searchInterestsForKey(key: String) {
        interests = Interest.createInterests()
        tableView.reloadData()
    }
    
    private var interests = [Interest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorColor = UIColor.clearColor()
        tableView.allowsSelection = false
        
        searchBar.delegate = self

        // Do any additional setup after loading the view.
        suggestInterests()
    }
    
    func suggestInterests() {
        interests = Interest.createInterests()
        tableView.reloadData()
    }
    
    @IBAction func dismiss(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func refreshButtonClicked(sender: UIButton) {
        // do something
    }
    
    @IBAction func hideKeyboardButtonClicked(sender: UIButton) {
        // do something
        searchBar.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DiscoverViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if searchBar.text != "" {
            searchText = searchBar.text?.lowercaseString
        }
        
        searchBar.resignFirstResponder()
    }
}

extension DiscoverViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interests.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Interest Cell", forIndexPath: indexPath) as! DiscoverTableViewCell
        
        cell.interest = interests[indexPath.row]
        cell.contentView.backgroundColor = UIColor.clearColor()
        
        return cell
    }
}



















