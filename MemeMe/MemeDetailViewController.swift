//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Lukasz Chrzanowski on 19/07/2015.
//  Copyright (c) 2015 ___LC___. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    @IBOutlet weak var memeImageView: UIImageView!
    var meme: Meme?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let memedImage = self.meme?.memedImage {
            self.memeImageView.image = memedImage
        }
    }
}
