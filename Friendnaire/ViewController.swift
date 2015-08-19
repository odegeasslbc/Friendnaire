//
//  ViewController.swift
//  Friendnaire
//
//  Created by LiuBingchen on 15/8/18.
//  Copyright (c) 2015年 LiuBingchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var postView = PostView()
        var gainView = GainView()
        postView.delegate = gainView
        gainView.delegate = postView
        self.view.addSubview(gainView)
        self.view.addSubview(postView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

