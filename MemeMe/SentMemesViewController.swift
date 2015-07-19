//
//  SentMemesViewController.swift
//  MemeMe
//
//  Created by Lukasz Chrzanowski on 16/07/2015.
//  Copyright (c) 2015 ___LC___. All rights reserved.
//

import Foundation
import UIKit

class SentMemesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    override func viewDidLoad() {
        super.viewDidLoad()
        //create some fake memes and add them to the model
        for ix in 1...10 {
        memes.append(
            Meme(topText: "dummy", bottomText: "\(ix)", image: UIImage(), memedImage: UIImage())
        )
        }
        println("\(memes)")
        println("SentMemesView did load")
    }
    
    
    var memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    
    
    @IBAction func addMeme(sender: UIBarButtonItem) {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.navigationController?.presentViewController(vc, animated: false, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //println("tableView \(memes.count)")
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
//        let cell = tableView.dequeueReusableCellWithIdentifier("VillainCell") as! UITableViewCell
//        let villain = self.allVillains[indexPath.row]
//        
//        // Set the name and image
//        cell.textLabel?.text = villain.name
//        cell.imageView?.image = UIImage(named: villain.imageName)
//        
//        // If the cell has a detail label, we will put the evil scheme in.
//        if let detailTextLabel = cell.detailTextLabel {
//            detailTextLabel.text = "Scheme: \(villain.evilScheme)"
//        }
//        
//        return cell
        //println("tableView cell")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell") as! UITableViewCell
        let meme = self.memes[indexPath.row]
        cell.textLabel?.text = "\(meme.topText) \(meme.bottomText)"
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("VillainDetailViewController") as! VillainDetailViewController
//        detailController.villain = self.allVillains[indexPath.row]
//        self.navigationController!.pushViewController(detailController, animated: true)
        //println("didSelectRowAtIndexPath")
        
    }
    
    
    
    
    
}
