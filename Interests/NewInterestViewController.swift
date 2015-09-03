//
//  NewInterestViewController.swift
//  Interests
//
//  Created by David on 2015/8/29.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit
import Photos

class NewInterestViewController: UIViewController {

    // MARK: - iboutlet
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var newInterestTitleTextField: DesignableTextField!
    @IBOutlet weak var newInterestDescriptionTextView: UITextView!
    @IBOutlet weak var createNewInterestButton: DesignableButton!
    @IBOutlet weak var selectFeaturedImageButton: DesignableButton!
    
    @IBOutlet var hideKyeboardInputAccessoryView: UIView!
    
    private var featuredImage: UIImage!
    
    // MARK: - VC lifecycle
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newInterestTitleTextField.inputAccessoryView = hideKyeboardInputAccessoryView
        newInterestDescriptionTextView.inputAccessoryView = hideKyeboardInputAccessoryView

        // Do any additional setup after loading the view.
        newInterestTitleTextField.becomeFirstResponder()
        newInterestTitleTextField.delegate = self
        newInterestDescriptionTextView.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "KeyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        self.newInterestDescriptionTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        self.newInterestDescriptionTextView.scrollIndicatorInsets = self.newInterestDescriptionTextView.contentInset
    }
    
    func KeyboardDidHide(notification: NSNotification) {
        self.newInterestDescriptionTextView.contentInset = UIEdgeInsetsZero
        self.newInterestDescriptionTextView.scrollIndicatorInsets = self.newInterestDescriptionTextView.contentInset
    }

    // MARK: Target / Action
    @IBAction func dismiss(sender: UIButton) {
        hideKeyboard()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func selectFeaturedImageButtonClicked(sender: DesignableButton) {
        
        let authorization = PHPhotoLibrary.authorizationStatus()
        
        if authorization == PHAuthorizationStatus.NotDetermined {
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.selectFeaturedImageButtonClicked(sender)
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
                        self.featuredImage = images[0]
                        self.backgroundImageView.image = self.featuredImage
                        self.backgroundColorView.alpha = 0.8
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
    
    @IBAction func createNewInterestButtonClicked(sender: DesignableButton) {
        if newInterestDescriptionTextView.text == "Describe your new interest..." || newInterestTitleTextField.text!.isEmpty {
            shakeTextField()
        } else if featuredImage == nil {
            shakePhotoButton()
        } else {
            // create a new interest
            // .. 
            self.hideKeyboard()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func shakeTextField() {
        newInterestTitleTextField.animation = "shake"
        newInterestTitleTextField.curve = "spring"
        newInterestTitleTextField.duration = 1.0
        newInterestTitleTextField.animate()
    }
    
    func shakePhotoButton() {
        selectFeaturedImageButton.animation = "shake"
        selectFeaturedImageButton.curve = "spring"
        selectFeaturedImageButton.duration = 1.0
        selectFeaturedImageButton.animate()
    }
    
    @IBAction func hideKeyboard() {
        if newInterestDescriptionTextView.isFirstResponder() {
            newInterestDescriptionTextView.resignFirstResponder()
        } else if newInterestTitleTextField.isFirstResponder() {
            newInterestTitleTextField.resignFirstResponder()
        }
    }
}

extension NewInterestViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.backgroundImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
// MARK: UItextfielddelegate
extension NewInterestViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if  newInterestDescriptionTextView.text == "Describe your new interest..." && !textField.text!.isEmpty {
            newInterestDescriptionTextView.becomeFirstResponder()
        } else if newInterestTitleTextField.text!.isEmpty {
            shakeTextField()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}

extension NewInterestViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        textView.text = ""
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        if textView.text.isEmpty {
            textView.text = "Describe your new interest..."
        }
        return true
    }
}