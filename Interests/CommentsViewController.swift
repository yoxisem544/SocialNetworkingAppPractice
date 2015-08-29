//
//  CommentsViewController.swift
//  Interests
//
//  Created by David on 2015/8/28.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    var post: Post!
    
    @IBOutlet weak var tableView: UITableView!
    private var newCommentButton: ActionButton!
    private var comments = [Comment]()

    // MARK: - view controller life cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchComments()
        
        // configure navigation bar
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "EE8222")
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        
        title = "Comments"
        
        // make the table view to have dynamic height
        tableView.estimatedRowHeight = 387.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.clearColor()
        tableView.allowsSelection = false
        
        // challenge write this function
        createNewPostButton()
    }
    
    func createNewPostButton() {
        
        // is this correct?
        newCommentButton = ActionButton(attachedToView: self.view, items: [])
        newCommentButton.action = { button in
            self.performSegueWithIdentifier("Show Post Composer", sender: nil)
        }
        // set the button's backgroundColor
    }
    private func fetchComments() {
        comments = Comment.allComments()
        tableView?.reloadData()
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}

extension CommentsViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // comments and the main post
        return (comments.count + 1)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if post.postImage == nil {
                let cell = tableView.dequeueReusableCellWithIdentifier("PostCellWithoutImage", forIndexPath: indexPath) as! PostTableViewCell
                cell.post = post
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("PostCellWithImage", forIndexPath: indexPath) as! PostTableViewCell
                cell.post = post
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Comment Cell", forIndexPath: indexPath) as! CommentTableViewCell
            cell.comment = self.comments[indexPath.row - 1]
            return cell
        }
    }
}














