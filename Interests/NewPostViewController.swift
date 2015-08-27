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
    }
    
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
        
    }

}
