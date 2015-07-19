//
//  Meme.swift
//  MemeMe
//
//  Created by Lukasz Chrzanowski on 16/07/2015.
//  Copyright (c) 2015 ___LC___. All rights reserved.
//

import Foundation
import UIKit

class Meme: Printable
{
    let topText: String
    let bottomText: String
    let image: UIImage
    //image with topText and bottomText overlayed
    let memedImage: UIImage
    
    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
    
    var description: String {
        get {
            return "Meme with topText=\(self.topText) bottomText=\(self.bottomText)"
        }
    }
}