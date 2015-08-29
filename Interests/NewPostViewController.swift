//
//  NewPostViewController.swift
//  Interests
//
//  Created by David on 2015/8/27.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit
import Photos

class NewPostViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var currentUserPorfileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postContentTxetView: UITextView!
    
    private var postImage: UIImage! // use this one to store post image - send it to Parse
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        postContentTxetView?.becomeFirstResponder()
        postContentTxetView?.text = ""
        
        currentUserPorfileImageView?.layer.cornerRadius = currentUserPorfileImageView.bounds.width / 2
        currentUserPorfileImageView.clipsToBounds = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardDidHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardDidShowNotification, object: nil)
    }
    
    // MARK: - text view handler
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        
        self.postContentTxetView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        self.postContentTxetView.scrollIndicatorInsets = self.postContentTxetView.contentInset
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.postContentTxetView.contentInset = UIEdgeInsetsZero
        self.postContentTxetView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    
    // MARK: - pick feature image
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func pickFeaturedImageClicked(sender: UITapGestureRecognizer) {
        
        let authorization = PHPhotoLibrary.authorizationStatus()
        
        if authorization == PHAuthorizationStatus.NotDetermined {
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.pickFeaturedImageClicked(sender)
                })
            })
            return
        }
        
        if authorization == PHAuthorizationStatus.Authorized {
            let controller = ImagePickerSheetController()
            
            controller.addAction(ImageAction(title: NSLocalizedString("Take Photo or Video", comment: "ActionTitle"), secondaryTitle: NSLocalizedString("Use this on", comment: "Action Title"), handler: { (_) -> () in
                self.presentCamera()
                }, secondaryHandler: { (action, numberOfPhotos) -> () in
                    controller.getSelectedImagesWithCompletion({ (images) -> Void in
                        self.postImage = images[0]
                        self.postImageView.image = self.postImage
                    })
            }))
            
            controller.addAction(ImageAction(title: NSLocalizedString("Cancel", comment: "Action Title"), style: ImageActionStyle.Cancel, handler: nil, secondaryHandler: nil))
            
            presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func presentCamera() {
        // chanllenge
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func dismiss() {
        self.postContentTxetView.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func post() {
        self.postContentTxetView.resignFirstResponder()
        // TODO: - create a new post, and send to parse
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension NewPostViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.postImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
