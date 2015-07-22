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
        self.imageView!.frame = CGRectMake(0.0, 0.0, 150.0, 100.0)
    }

}
