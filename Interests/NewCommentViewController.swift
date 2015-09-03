//
//  NewCommentViewController.swift
//  Interests
//
//  Created by David on 2015/8/29.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit

class NewCommentViewController: UIViewController {
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        
        commentTextView?.becomeFirstResponder()
        commentTextView?.text = ""
        
        userProfileImageView?.layer.cornerRadius = userProfileImageView.bounds.width / 2
        userProfileImageView?.clipsToBounds = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "KeyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        self.commentTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        self.commentTextView.scrollIndicatorInsets = self.commentTextView.contentInset
    }
    
    func KeyboardDidHide(notification: NSNotification) {
        self.commentTextView.contentInset = UIEdgeInsetsZero
        self.commentTextView.scrollIndicatorInsets = self.commentTextView.contentInset
    }

    @IBAction func dismiss() {
        self.commentTextView.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func post() {
        self.commentTextView.resignFirstResponder()
        // TODO: - create a new post, and send to parse
        self.dismissViewControllerAnimated(true, completion: nil)
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
