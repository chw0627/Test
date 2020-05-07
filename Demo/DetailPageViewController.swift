//
//  DetailPageViewController.swift
//  Demo
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class DetailPageViewController: UIViewController {

    var itemId:String = ""
    var itemTitle:String = ""
    var thumbnailUrl:String = ""
    let fullScreenSize:CGSize = UIScreen.main.bounds.size

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let img = UIImageView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.height)!, width: fullScreenSize.width, height: fullScreenSize.height/2))
        let imageUrl:NSURL = NSURL(string: thumbnailUrl)!
        DispatchQueue.global(qos: .userInitiated).async {
            let imageData:NSData = NSData(contentsOf: imageUrl as URL)!
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                img.image = image
            }
        }
        self.view.addSubview(img)
        
        let idLabel = UILabel(frame: CGRect(x: 30, y:(self.navigationController?.navigationBar.frame.height)!+fullScreenSize.height/2+30, width: fullScreenSize.width-60, height: fullScreenSize.width/20))
        idLabel.text = "id: " + itemId
        idLabel.font = idLabel.font.withSize(fullScreenSize.width/20)
        self.view.addSubview(idLabel)
        
        let titleLabel = UILabel(frame: CGRect(x: 30, y:(self.navigationController?.navigationBar.frame.height)!+fullScreenSize.height/2+60, width: fullScreenSize.width-60, height: fullScreenSize.width/5))
        titleLabel.text = "title: " + itemTitle
        titleLabel.font = titleLabel.font.withSize(fullScreenSize.width/20)
        titleLabel.lineBreakMode = NSLineBreakMode.byCharWrapping
        titleLabel.numberOfLines = 0
        self.view.addSubview(titleLabel)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
