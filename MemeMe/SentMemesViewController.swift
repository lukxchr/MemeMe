//
//  SentMemesViewController.swift
//  MemeMe
//
//  Created by Lukasz Chrzanowski on 16/07/2015.
//  Copyright (c) 2015 ___LC___. All rights reserved.
//

import Foundation
import UIKit

class SentMemesViewController: UIViewController,
    UITableViewDelegate, UITableViewDataSource,
    UICollectionViewDataSource
{
    override func viewDidLoad() {
        super.viewDidLoad()
        //create some fake memes and add them to the model
        //let img = UIImage(named: "LaunchScreen")!
//        let placeholderImageView = UIImageView(frame: CGRectMake(100, 150, 150, 150))
//        placeholderImageView.image = UIImage()
        //println("placeholderImage: size:\(placeholderImage.size)")
        //let img = UIImage()
        for ix in 1...30 {
        memes.append(
            Meme(topText: "dummy", bottomText: "\(ix)", image: UIImage(), memedImage: UIImage(named: "LaunchImage")!)
        )
        }
//        println("\(memes)")
//        println("SentMemesView did load")
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
    
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell") as! UITableViewCell
        let meme = self.memes[indexPath.row]
        cell.textLabel?.text = "\(meme.topText) \(meme.bottomText)"
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println("\(self.memes.count)")
        return self.memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[indexPath.row]
        
        // Set the name and image
//        cell.bottomLabel.text = meme.bottomText
//        cell.topLabel.text = meme.topText
        cell.imageView.image = meme.memedImage
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
    
    
    
}
