//
//  MyCollectionViewCell.swift
//  Demo
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    var imageView:UIImageView!
    var idLabel:UILabel!
    var titleLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let w = Double(UIScreen.main.bounds.size.width)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: w/4, height: w/4))
        self.addSubview(imageView)
        
        idLabel = UILabel(frame: CGRect(x: 0, y: w/16, width: w/4, height: w/20))
        idLabel.textAlignment = .center
        idLabel.textColor = UIColor.black
        idLabel.font = idLabel.font.withSize(CGFloat(w/20))
        self.addSubview(idLabel)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: w/8, width: w/4, height: w/4-w/8))
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.font = titleLabel.font.withSize(CGFloat(w/20))
        self.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
