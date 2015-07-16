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
    

    @IBOutlet weak var memeImage: UIImageView!
    //buttons
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //set delegates
        //imagePicker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
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
        //println("picked image")
        //println(info)
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImage.image = chosenImage
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}

