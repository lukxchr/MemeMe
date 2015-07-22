//
//  MemeTableViewCell.swift
//  
//
//  Created by Lukasz Chrzanowski on 22/07/2015.
//
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //make imageViews equal-sized, image in the centre with original aspect ratio
        self.imageView!.frame = CGRectMake(0.0, 0.0, 150.0, 100.0)
        self.imageView!.contentMode = .ScaleAspectFit
        self.imageView!.backgroundColor = .darkGrayColor()
        
        //position textLabel 20p from the right edge of the imageView
        var origin = self.textLabel!.frame.origin
        origin.x = 170.0
        self.textLabel!.frame.origin = origin
    }

}
