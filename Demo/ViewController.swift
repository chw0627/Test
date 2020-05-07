//
//  ViewController.swift
//  Demo
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let fullScreenSize:CGSize = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let myLabel = UILabel(frame: CGRect(x: 0, y: fullScreenSize.height/4, width: fullScreenSize.width, height: fullScreenSize.width/20))
        myLabel.text = "JSON Placeholder"
        myLabel.textAlignment = .center
        myLabel.textColor = .black
        myLabel.font = myLabel.font.withSize(CGFloat(fullScreenSize.width/20))
        self.view.addSubview(myLabel)
        
        let myButton = UIButton(frame: CGRect(x: fullScreenSize.width/2-fullScreenSize.width/20*6, y: fullScreenSize.height/2-20, width: fullScreenSize.width/20*12, height: fullScreenSize.width/20))
        myButton.setTitle("Request API", for: .normal)
        myButton.setTitleColor(UIColor.blue, for: .normal)
        myButton.titleLabel?.font = myButton.titleLabel?.font.withSize(fullScreenSize.width/20)
        myButton.titleLabel?.adjustsFontForContentSizeCategory = true
        myButton.addTarget(self, action: #selector(ViewController.goJsonPlaceHolderPage), for: .touchUpInside)
        self.view.addSubview(myButton)
    }

    @objc func goJsonPlaceHolderPage() {
        self.navigationController!.pushViewController(JsonPlaceHolderViewController(), animated: true)
    }
    
    
}

