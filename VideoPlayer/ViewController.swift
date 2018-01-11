//
//  ViewController.swift
//  VideoPlayer
//
//  Created by 虞嘉伟 on 2018/1/11.
//  Copyright © 2018年 虞嘉伟. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let download = Download()
        download.beginDownload()
        
    }
}

