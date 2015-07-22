//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Lukasz Chrzanowski on 14/07/2015.
//  Copyright (c) 2015 ___LC___. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    UITextFieldDelegate
{
    //buttons
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    //other outlets
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var memeImageViewHeightConstraint: NSLayoutConstraint!
    
    //style attributes for text to be overalyed over the image
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0,
    ]
    var memedImage: UIImage! //store image with text overlayed in this variable, see generateMemeImage

    override func viewDidLoad() {
        super.viewDidLoad()
        //set textfields' style
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        //set delegates for thextFields
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        //disable share button for now and enable when user adds an image
        shareButton.enabled = false
        
        //set memeImage height, this will change once user loads an image
        memeImageViewHeightConstraint.constant =
            UIScreen.mainScreen().applicationFrame.size.height - 50
        
        
    }
    
    //MARK: ViewController lifecycle methods
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //disable camera button for devices without camera
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.unsubscribeFromKeyboardNotifications()
    }
    
    //MARK: Methods for loading images from albums or camera
    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let bounds = CGRect(origin: CGPointZero, size: chosenImage.size)
            
            memeImage.bounds = bounds
            memeImage.image = chosenImage
            
            //make image fill the whole screen width; then figure out the appropriate
            //height and set the size of the memeImageView to fit the image by updating its height constraint
            let screenWidth = UIScreen.mainScreen().applicationFrame.size.width
            let imageHeightWidthRatio = chosenImage.size.height / chosenImage.size.width
            memeImageViewHeightConstraint.constant = screenWidth * imageHeightWidthRatio
            
            //enable share button after user adds image
            shareButton.enabled = true
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil)
        //activityController.completionWithItemsHandler = saveHandler
        
        activityController.completionWithItemsHandler = {
            (activityType, completed, returnedItems, error) in
            self.save() //segues to SentMemes view
        }
    }
    
    //MARK: methods releated to sliding the view when the keybord dis-/appears
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }

    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    //MARK: generate and save memes
    func generateMemedImage() -> UIImage
    {
        //hide navbar and toolbar
        navBar.hidden = true
        toolbar.hidden = true
        
        //take "screenshot" of the portion of the screen where the images 
        //with text is located and save it as an UIImage
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext())
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let rect = CGRect(origin: memeImage.frame.origin, size: memeImage.frame.size)
        let imageRef = CGImageCreateWithImageInRect(viewImage.CGImage, rect)
        let memedImage = UIImage(CGImage: imageRef)!
        
        //show navbar and toolbar
        navBar.hidden = false
        toolbar.hidden = false
        
        return memedImage
    }
    
    func save() {
        //Create the meme
        let meme = Meme(topText: topTextField.text!,
            bottomText: bottomTextField.text!,
            image: memeImage.image!,
            memedImage: memedImage)
        
        //save the new meme
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        appDelegate.memes.append(meme)
        
        self.performSegueWithIdentifier("showSentMemes", sender: self)
    }
    
    //MARK: TextField delegate methods
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.becomeFirstResponder()
        //clear if user starts editing default values
        if (textField.text == "TOP") || (textField.text == "BOTTOM") {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

