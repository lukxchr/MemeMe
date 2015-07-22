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
    UINavigationControllerDelegate
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
    
    //delegates
    let memeTextFieldDelegate = MemeTextFieldDelegate()
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0,
    ]
    
    var memedImage: UIImage! //store image with text overlayed in this variable

    override func viewDidLoad() {
        super.viewDidLoad()
        //set textfields' style
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        //set delegates
        topTextField.delegate = memeTextFieldDelegate
        bottomTextField.delegate = memeTextFieldDelegate
        
        //disable share button for now and enable when user adds an image
        shareButton.enabled = false
        
        memeImageViewHeightConstraint.constant =
            UIScreen.mainScreen().applicationFrame.size.height - 50
        
        
    }
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
//            memeImage.image = chosenImage
            
            let bounds = CGRect(origin: CGPointZero, size: chosenImage.size)
            
            memeImage.bounds = bounds
            memeImage.image = chosenImage
            
            //memeImageViewHeightConstraint.constant = memeImage.image!.size.height
                //?? memeImageViewHeightConstraint.constant
            //println("new height: \(memeImage.image!.size.height); width: \(memeImage.image!.size.width)")
            //println(":: \(memeImage.image!.size.height / memeImage.image!.size.width)")
            
            let screenWidth = UIScreen.mainScreen().applicationFrame.size.width
            let imageHeightWidthRatio = chosenImage.size.height / chosenImage.size.width
            memeImageViewHeightConstraint.constant = screenWidth * imageHeightWidthRatio
            
            //println("view: \(memeImage.frame.size)  image: \(memeImage.image!.size) ")
            //println("\(self.view.subviews[0])")
            
            
            //self.view.addSubview(memeImage.image!.drawAtPoint(CGPoint(x: 100.0, y: 100.0)))
            //self.view.setNeedsDisplay()
            
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
//        let com = activityController.completionWithItemsHandler
//        println("\(com)")
        activityController.completionWithItemsHandler = saveHandler
    }
    
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
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
    
    func generateMemedImage() -> UIImage
    {
        //hide navbar and toolbar
        navBar.hidden = true
        toolbar.hidden = true
        
        // Render view to an image
//        println("sel.view frame \(self.view.frame.origin) -- \(self.view.frame.size)")
//        println("memeImage frame \(self.memeImage.frame.origin) -- \(self.memeImage.frame.size)")
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        self.view.drawViewHierarchyInRect(self.view.frame,
//            afterScreenUpdates: true)
//        let memedImage : UIImage =
//        UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
        
        
        // Render view to an image
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        
//        let rect = CGRect(origin: self.memeImage.frame.origin, size: self.memeImage.frame.size)
//        
//        self.view.drawViewHierarchyInRect(rect,
//            afterScreenUpdates: true)
//        let memedImage : UIImage =
//        UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
        
        
//        let rect = UIScreen.mainScreen().bounds
//        println("UIScreen.mainScreen().bounds:  \(UIScreen.mainScreen().bounds)")
//        UIGraphicsBeginImageContext(rect.size)
//        let context = UIGraphicsGetCurrentContext()
//        self.view.layer.renderInContext(context)
//        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
        
        
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
        println("\(meme)")
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        appDelegate.memes.append(meme)
        self.performSegueWithIdentifier("showSentMemes", sender: self)
    }
    
    func saveHandler(activityType:String!, completed: Bool,
        returnedItems: [AnyObject]!, error: NSError!) {
            save()
    }

}

