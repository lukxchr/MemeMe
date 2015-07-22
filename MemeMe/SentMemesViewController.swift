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

        for ix in 1...30 {
        memes.append(
            Meme(topText: "dummy", bottomText: "\(ix)", image: UIImage(), memedImage: UIImage(named: "LaunchImage")!)
        )
            
        }
    }
    
    var memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    
    @IBAction func addMeme(sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.navigationController?.presentViewController(vc, animated: false, completion: nil)
    }
    
    //MARK: TableView delegate methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    //MARK: CollectionView delegate methods
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println("\(self.memes.count)")
        return self.memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[indexPath.row]
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
